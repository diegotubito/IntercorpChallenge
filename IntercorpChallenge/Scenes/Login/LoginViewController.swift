//
//  LoginViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var alert: DDAlert!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        alert = DDAlert()
    }
    
    @IBAction func loginDidPress(_ sender: Any) {
        guard let username = usernameTextfield.text,
              let password = passwordTextfield.text,
              !username.isEmpty, !password.isEmpty
        else {
            alert.SingleButton(title: "Error", body: "Username and Password required", buttonTitle: "OK")
            return
        }
        
        AuthManager.shared.signInWithEmail(email: username, password: password, success: { (result) in
        }) { (error) in
            DispatchQueue.main.async {
                self.alert.SingleButton(title: "Error", body: error?.localizedDescription ?? "unknown error", buttonTitle: "OK")
            }
        }
    }
}
