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
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    @IBAction func loginDidPress(_ sender: Any) {
        guard let username = usernameTextfield.text else {
            return
        }
        
        guard let password = passwordTextfield.text else {
            return
        }
        AuthManager.shared.signInWithEmail(email: username, password: password, success: { (result) in
            
           
        }) { (error) in
            
            print("wrong")
        }
    }
}
