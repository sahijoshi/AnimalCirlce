//
//  LoginViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 1.1.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: BorderTextField!
    @IBOutlet weak var txtPassword: BorderTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
    }
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "SignupViewController", sender: nil)
    }
}
