//
//  ViewScoreViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 17.4.2021.
//

import UIKit

class ViewScoreViewController: UIViewController {
    var score: Score?
    @IBOutlet weak var btnScore: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnScore.setTitle("\(score!.score) / \(score!.totalScore)", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func retakeQuiz(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanAgain(_ sender: Any) {
        let array = navigationController?.viewControllers
        navigationController?.popToViewController(array![1], animated: true)
    }
}
