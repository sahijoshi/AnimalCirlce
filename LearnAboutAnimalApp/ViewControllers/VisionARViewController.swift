/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main view controller for the ARKitVision sample.
*/

import UIKit
import SpriteKit
import ARKit
import Vision
import AVFoundation

class VisionARViewController: UIViewController, UIGestureRecognizerDelegate, ARSessionDelegate, ARSCNViewDelegate {
    var infoDetail: InfoDetail?
    var infoBrief: InfoBrief?
    var selectedAnimal = ""
    var player: AVAudioPlayer?

    @IBOutlet weak var btnQuix: UIButton!
    @IBOutlet weak var containerQuiz: UIView!
    @IBOutlet weak var sceneView: ARSCNView!
    let bubbleDepth : Float = 0.01 // the 'depth' of 3D text
    var latestPrediction : String = "…"
    private var _resnet50Model: Resnet50!
    private var resnet50Model: Resnet50! {
        get {
            if let model = _resnet50Model { return model }
            _resnet50Model = {
                do {
                    let configuration = MLModelConfiguration()
                    return try Resnet50(configuration: configuration)
                } catch {
                    fatalError("Couldn't create Inceptionv3 due to: \(error)")
                }
            }()
            return _resnet50Model
        }
    }
    // The view controller that displays the status and "restart experience" UI.
    private lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerQuiz.isHidden = true
        btnQuix.layer.cornerRadius = 5
        // Configure and present the SpriteKit scene that draws overlay content.
//        let overlayScene = SKScene()
//        overlayScene.scaleMode = .aspectFill
        sceneView.delegate = self
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Enable Default Lighting - makes the 3D text a bit poppier.
        sceneView.autoenablesDefaultLighting = true

//        sceneView.presentScene(overlayScene)
        sceneView.session.delegate = self
        
        // Hook up status view controller callback.
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartSession()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? QuizViewController {
            if let selectedAnimal = sender as? String {
                destination.selectedAnimal = selectedAnimal
            }
        }
    }

    
    // MARK: - ARSessionDelegate
    
    // Pass camera frames received from ARKit to Vision (when not already processing one)
    /// - Tag: ConsumeARFrames
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Do not enqueue other buffers for processing while another Vision task is still running.
        // The camera stream has only a finite amount of buffers available; holding too many buffers for analysis would starve the camera.
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }
        
        // Retain the image buffer for Vision processing.
        self.currentBuffer = frame.capturedImage
        classifyCurrentImage()
    }
    
    // MARK: - Vision classification
    
    // Vision classification request and model
    /// - Tag: ClassificationRequest
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Instantiate the model from its generated Swift class.
            let model = try VNCoreMLModel(for: resnet50Model.model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            
            // Crop input images to square area at center, matching the way the ML model was trained.
            request.imageCropAndScaleOption = .centerCrop
            
            // Use CPU for Vision processing to ensure that there are adequate GPU resources for rendering.
            request.usesCPUOnly = true
            
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    // The pixel buffer being held for analysis; used to serialize Vision requests.
    private var currentBuffer: CVPixelBuffer?
    
    // Queue for dispatching vision classification requests
    private let visionQueue = DispatchQueue(label: "com.example.apple-samplecode.ARKitVision.serialVisionQueue")
    
    // Run the Vision+ML classifier on the current image buffer.
    /// - Tag: ClassifyCurrentImage
    private func classifyCurrentImage() {
        // Most computer vision tasks are not rotation agnostic so it is important to pass in the orientation of the image with respect to device.
        let orientation = CGImagePropertyOrientation(UIDevice.current.orientation)
        
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: currentBuffer!, orientation: orientation)
        visionQueue.async {
            do {
                // Release the pixel buffer when done, allowing the next buffer to be processed.
                defer { self.currentBuffer = nil }
                try requestHandler.perform([self.classificationRequest])
            } catch {
                print("Error: Vision request failed with error \"\(error)\"")
            }
        }
    }
    
    // Classification results
    private var identifierString = ""
    private var confidence: VNConfidence = 0.0
    
    // Handle completion of the Vision request and choose results to display.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results else {
            print("Unable to classify image.\n\(error!.localizedDescription)")
            return
        }
        // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
        let classifications = results as! [VNClassificationObservation]
        
        // Show a label for the highest-confidence result (but only above a minimum confidence threshold).
        if let bestResult = classifications.first(where: { result in result.confidence > 0.5 }),
            let label = bestResult.identifier.split(separator: ",").first {
            identifierString = String(label)
            confidence = bestResult.confidence
        } else {
            identifierString = ""
            confidence = 0
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.displayClassifierResults()
        }
    }
    
    // Show the classification results in the UI.
    private func displayClassifierResults() {
        guard !self.identifierString.isEmpty else {
            return // No object was classified.
        }
//        let message = String(format: "Detected \(self.identifierString) with %.2f", self.confidence * 100) + "% confidence"
        let message = "Detected: Tap on object"
        statusViewController.showMessage(message)
    }
    
    // MARK: - Tap gesture handler & ARSKViewDelegate
    
    // Labels for classified objects by ARAnchor UUID
    private var anchorLabels = [UUID: String]()
    
    // When the user taps, add an anchor associated with the current classification result.
    /// - Tag: PlaceLabelAtLocation
    @IBAction func placeLabelAtLocation(sender: UITapGestureRecognizer) {
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint])
        
        if let closestResult = arHitTestResults.first {
            // Get Coordinates of HitTest
            let transform : matrix_float4x4 = closestResult.worldTransform
            let worldCoord : SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)

            DispatchQueue.main.async { [self] in
                self.containerQuiz.isHidden = false
                let physicalWidth: CGFloat = 0.09
                let physicalHeight: CGFloat = 0.1
                let cornerRadius:CGFloat = 0.01
                
                var animalData = [String: String]()
                var imageName = ""
                if self.identifierString.lowercased().contains("tiger") {
                    selectedAnimal = "tiger"
                    imageName = "tiger"
                    animalData = DataProvider.dataTiger()
                }

                if self.identifierString.lowercased().contains("elephant") {
                    selectedAnimal = "elephant"
                    imageName = "elephant"
                    animalData = DataProvider.dataElephant()
                }
                
                if self.identifierString.lowercased().contains("panda") {
                    selectedAnimal = "panda"
                    imageName = "panda"
                    animalData = DataProvider.dataPanda()
                }

                if self.identifierString.lowercased().contains("bear") {
                    selectedAnimal = "bear"
                    imageName = "bear"
                    animalData = DataProvider.dataBear()
                }

                self.infoDetail = InfoDetail().loadView()
                self.infoDetail?.txtStatus.text = animalData["status"]
                self.infoDetail?.txtClassification.text = animalData["classification"]
                self.infoDetail?.txtDiet.text = animalData["diet"]
                self.infoDetail?.txtLife.text = animalData["lifeSpan"]
                self.infoDetail?.txtHeight.text = animalData["height"]
                self.infoDetail?.txtWeight.text = animalData["weight"]
                self.infoDetail?.txtHabitat.text = animalData["habitat"]

                let webViewPlane = SCNPlane(width: physicalWidth, height: physicalHeight)
                webViewPlane.cornerRadius = cornerRadius
                
                let webViewNode = SCNNode(geometry: webViewPlane)
                webViewNode.geometry?.firstMaterial?.diffuse.contents = self.infoDetail
                webViewNode.opacity = 0.98

                self.sceneView.scene.rootNode.addChildNode(webViewNode)
                webViewNode.position = worldCoord
                webViewNode.position.x += 0.05

                self.infoBrief = InfoBrief().loadView()
                self.infoBrief?.lblTitle.text = animalData["name"]
                self.infoBrief?.txtBriefInfo.text = animalData["detail"]
                let infoBriefPlane = SCNPlane(width: physicalWidth, height: physicalHeight)
                infoBriefPlane.cornerRadius = cornerRadius
                
                let infoBriefNode = SCNNode(geometry: infoBriefPlane)
                infoBriefNode.geometry?.firstMaterial?.diffuse.contents = self.infoBrief
                infoBriefNode.position.z -= 0.6
                infoBriefNode.opacity = 0.95

                self.sceneView.scene.rootNode.addChildNode(infoBriefNode)
                infoBriefNode.position = worldCoord
                infoBriefNode.position.x -= 0.05
                
                let imageView = UIImageView(image: UIImage(named: imageName))
                let imgMaterial = SCNMaterial()
                imgMaterial.diffuse.contents = imageView
                let imgPlane = SCNPlane(width: 0.07, height: 0.07)
                imgPlane.materials = [imgMaterial]

                let imgNode = SCNNode(geometry: imgPlane)
                self.sceneView.scene.rootNode.addChildNode(imgNode)
                imgNode.position = worldCoord
                imgNode.position.y += 0.09
            }
        }
    }
    
    // When an anchor is added, provide a SpriteKit node for it and set its text to the classification label.
    /// - Tag: UpdateARContent
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
            
    // MARK: - AR Session Handling
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
        
        switch camera.trackingState {
        case .notAvailable, .limited:
            statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
        case .normal:
            statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
            // Unhide content after successful relocalization.
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        // Filter out optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        DispatchQueue.main.async {
            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {

    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        /*
         Allow the session to attempt to resume after an interruption.
         This process may not succeed, so the app must be prepared
         to reset the session if the relocalizing status continues
         for a long time -- see `escalateFeedback` in `StatusViewController`.
         */
        return true
    }

    private func restartSession() {
        print("restart session")
        self.containerQuiz.isHidden = true
        statusViewController.cancelAllScheduledMessages()
        statusViewController.showMessage("RESTARTING SESSION")
        
        anchorLabels = [UUID: String]()
        
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK: - Error handling
    
    private func displayErrorMessage(title: String, message: String) {
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.restartSession()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func takeQuizAction(_ sender: Any) {
        performSegue(withIdentifier: "quizVC", sender: selectedAnimal)
    }
    
    @IBAction func soundAction(_ sender: Any) {
        var soundName = ""
        if selectedAnimal.contains("tiger") {
            soundName = "tiger"
        }

        if selectedAnimal.contains("elephant") {
            soundName = "elephant"
        }
        
        if selectedAnimal.contains("panda") {
            soundName = "panda"
        }

        if selectedAnimal.contains("bear") {
            soundName = "polarBear"
        }
        
        DispatchQueue.main.async { [self] in
            let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")

            do {
                self.player = try AVAudioPlayer(contentsOf: url!)
                guard let player = self.player else { return }

               player.prepareToPlay()
               player.play()
            } catch let error { print(error.localizedDescription) }

        }
    }
    
}
