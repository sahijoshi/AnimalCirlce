//
//  QuizViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 17.4.2021.
//

import UIKit
import AVFoundation

struct Score {
    var score = 0
    var totalScore = 0
    
    init(score: Int, totalScore: Int) {
        self.score = score
        self.totalScore = totalScore
    }
}

class QuizViewController: UIViewController {
    @IBOutlet weak var btnOption1: QuizButton!
    @IBOutlet weak var btnOption2: QuizButton!
    @IBOutlet weak var btnOption3: QuizButton!
    @IBOutlet weak var btnOption4: QuizButton!
    
    @IBOutlet weak var btnYesNoOption1: QuizButton!
    @IBOutlet weak var btnYesNoOption2: QuizButton!

    @IBOutlet weak var containerFourOptions: UIView!
    @IBOutlet weak var containerTwoOptions: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var containerQuestion: UIView!
    @IBOutlet weak var txtQuestion: UITextView!
    
    @IBOutlet weak var btnSound: UIButton!

    var selectedAnimal = ""
    var questions = [Questions]()
    var question = Questions()
    var questionIndex = 0
    var buttons = [QuizButton]()
    var score = 0
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "Take Quiz"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UINavigationBar.appearance().isTranslucent = false
        setupUIs()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ViewScoreViewController {
            if let score = sender as? Score {
                destination.score = score
            }
        }
    }

    func setupUIs() {
        containerFourOptions.isHidden = true
        containerTwoOptions.isHidden = true
        btnSound.isHidden = true
        
        containerFourOptions.layer.cornerRadius = 5
        containerTwoOptions.layer.cornerRadius = 5
        containerQuestion.layer.cornerRadius = 5
        btnContinue.layer.cornerRadius = 5
        
        buttons.append(btnOption1)
        buttons.append(btnOption2)
        buttons.append(btnOption3)
        buttons.append(btnOption4)
        buttons.append(btnYesNoOption1)
        buttons.append(btnYesNoOption2)
        
        enableBtns(true)
        loadQuestions()
    }
    
    func loadQuestions() {
        if selectedAnimal.lowercased() == "tiger" {
            questions = QuizQuestions.getQuizQuestionsForTiger()
        }
        score = 0
        questionIndex = 0
        displayQuestionAndAnswers(index: questionIndex)
    }
    
    func displayQuestionAndAnswers(index: Int) {
        let aQuestion = questions[index]
        question = aQuestion
        txtQuestion.text = question.question
        displayOptionsForQuestion(question: question)
    }
    
    func displayOptionsForQuestion(question: Questions) {
        btnOption1.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        btnOption2.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        btnOption3.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        btnOption4.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        btnYesNoOption1.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        btnYesNoOption2.backgroundColor = UIColor(red: 240, green: 240, blue: 240)

        containerFourOptions.isHidden = true
        containerTwoOptions.isHidden = true
        btnSound.isHidden = true

        switch question.type {
        case .normal:
            containerFourOptions.isHidden = false
            btnOption1.setTitle(question.options[0], for: .normal)
            btnOption2.setTitle(question.options[1], for: .normal)
            btnOption3.setTitle(question.options[2], for: .normal)
            btnOption4.setTitle(question.options[3], for: .normal)
        case .yesNo:
            containerTwoOptions.isHidden = false
            btnYesNoOption1.setTitle(question.options[0], for: .normal)
            btnYesNoOption2.setTitle(question.options[1], for: .normal)
        case .sound:
            btnSound.isHidden = false
            containerFourOptions.isHidden = false
            btnOption1.setTitle(question.options[0], for: .normal)
            btnOption2.setTitle(question.options[1], for: .normal)
            btnOption3.setTitle(question.options[2], for: .normal)
            btnOption4.setTitle(question.options[3], for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func checkAnswer(_ btn: QuizButton) {
        let selectedAnswerTag = btn.tag
        let correctAnswerTag = question.answerIndex
        
       highlightGreen(correctAnswerTag)
        if selectedAnswerTag != correctAnswerTag {
            highlightRed(selectedAnswerTag)
        } else {
            score = score + 1
        }
    }
    
    func highlightGreen(_ index: Int) {
        for btn in buttons {
            if btn.tag == index {
                btn.backgroundColor = .green
            }
        }
    }
    
    func highlightRed(_ wrongIndex: Int) {
        for btn in buttons {
            if btn.tag == wrongIndex {
                btn.backgroundColor = .red
            }
        }
    }
    
    func enableBtns(_ flag: Bool) {
        btnOption1.isEnabled = flag
        btnOption2.isEnabled = flag
        btnOption3.isEnabled = flag
        btnOption4.isEnabled = flag
        btnYesNoOption1.isEnabled = flag
        btnYesNoOption1.isEnabled = flag
    }
    
    @IBAction func continueAction(_ sender: Any) {
        questionIndex = questionIndex + 1
        if questionIndex > questions.count - 1 {
            let aScore = Score(score: score, totalScore: questions.count)
            performSegue(withIdentifier: "ViewScoreViewController", sender: aScore)
        } else {
            displayQuestionAndAnswers(index: questionIndex)
            enableBtns(true)
        }
    }
    
    @IBAction func option1Selected(_ sender: Any) {
        let btn = sender as! QuizButton
        switch question.type {
        case .normal:
            checkAnswer(btn)
            enableBtns(false)
        case .yesNo:
            checkAnswer(btn)
            enableBtns(false)
        case .sound:
            checkAnswer(btn)
            enableBtns(false)
            
        }
    }
    
    @IBAction func option2Selected(_ sender: Any) {
        let btn = sender as! QuizButton
        switch question.type {
        case .normal:
            checkAnswer(btn)
            enableBtns(false)
        case .yesNo:
            checkAnswer(btn)
            enableBtns(false)
        case .sound:
            checkAnswer(btn)
            enableBtns(false)

        }
    }

    @IBAction func option3Selected(_ sender: Any) {
        let btn = sender as! QuizButton
        switch question.type {
        case .normal:
            checkAnswer(btn)
            enableBtns(false)
        case .yesNo:
            checkAnswer(btn)
            enableBtns(false)
        case .sound:
            checkAnswer(btn)
            enableBtns(false)

        }
    }

    @IBAction func option4Selected(_ sender: Any) {
        let btn = sender as! QuizButton
        switch question.type {
        case .normal:
            checkAnswer(btn)
            enableBtns(false)
        case .yesNo:
            checkAnswer(btn)
            enableBtns(false)
        case .sound:
            checkAnswer(btn)
            enableBtns(false)

        }
    }
    
    @IBAction func playSound(_ sender: Any) {
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
