//
//  SignupViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 3.1.2021.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var txtName: BorderTextField!
    @IBOutlet weak var txtEmail: BorderTextField!
    @IBOutlet weak var txtPassword: BorderTextField!
    @IBOutlet weak var txtConfirmPassword: BorderTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func signup(_ sender: Any) {
        
    }
}
