//
//  LoginViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 1.1.2021.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: BorderTextField!
    @IBOutlet weak var txtPassword: BorderTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func prepareCredential() -> [String: String] {
        var data = [String: String]()
        data["email"] = txtEmail.text
        data["password"] = txtPassword.text
        return data
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if txtEmail.text!.isEmpty {
            SVProgressHUD.showError(withStatus: "Please input your email.")
            return
        }
        
        if txtPassword.text!.isEmpty {
            SVProgressHUD.showError(withStatus: "Please input your password.")
            return
        }
        
        let credential = prepareCredential()
        WebServices.login(credential: credential) { (result) in
            switch result {
            case .success(let data):
                if data.status! {
                    DispatchQueue.main.sync {
                        self.performSegue(withIdentifier: "VisionViewController", sender: nil)
                    }
                }
            case .failure(let error):
                dLog(error.localizedDescription)
            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "SignupViewController", sender: nil)
    }
}
