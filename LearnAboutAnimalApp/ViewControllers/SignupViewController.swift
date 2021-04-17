//
//  SignupViewController.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 3.1.2021.
//

import UIKit
import SVProgressHUD

class SignupViewController: UIViewController {
    @IBOutlet weak var txtName: BorderTextField!
    @IBOutlet weak var txtEmail: BorderTextField!
    @IBOutlet weak var txtPassword: BorderTextField!
    @IBOutlet weak var txtConfirmPassword: BorderTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.hideKeyboardWhenTappedAround()
    }
    
    func verifyPassword() -> Bool {
        return txtPassword.text == txtConfirmPassword.text
    }
    
    func preparePayload() -> [String: String] {
        var data = [String: String]()
        data["name"] = txtName.text
        data["email"] = txtEmail.text
        data["password"] = txtConfirmPassword.text
        return data
    }
    
    @IBAction func signup(_ sender: Any) {
        if !verifyPassword() {
            SVProgressHUD.showError(withStatus: "Please input correct information.")
            return
        }
        
        let payload = preparePayload()
        WebServices.signup(payload: payload) { (result) in
            switch result {
            case .success(let data):
                if data.status! {
                    dLog(data.message)
                    SVProgressHUD.showSuccess(withStatus: "Successfully signed up.")
                }
            case .failure(let error):
                dLog(error.localizedDescription)
            }
        }
    }
}
