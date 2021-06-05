//
//  LoginViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var alert: DDAlert!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        alert = DDAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        usernameTextfield.text = "diego@icloud.com"
        passwordTextfield.text = "admin1234"
    }
    
    @IBAction func loginDidPress(_ sender: Any) {
        guard let username = usernameTextfield.text,
              let password = passwordTextfield.text,
              !username.isEmpty, !password.isEmpty
        else {
            alert.SingleButton(title: "Error", body: "Username and Password required", buttonTitle: "OK")
            return
        }
        
        loginButtonOutlet.isEnabled = false
        AuthManager.shared.signInWithEmail(email: username, password: password, success: { (result) in
            
        }) { (error) in
            self.loginButtonOutlet.isEnabled = true
            DispatchQueue.main.async {
                self.alert.SingleButton(title: "Error", body: error?.localizedDescription ?? "unknown error", buttonTitle: "OK")
            }
        }
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextfield {
            passwordTextfield.becomeFirstResponder()
        } else {
            passwordTextfield.resignFirstResponder()
        }
        return true
    }
}
