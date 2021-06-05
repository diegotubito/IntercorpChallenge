//
//  ViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    @IBAction func powerButtonPressed(_ sender: Any) {
        AuthManager.shared.signOut()
    }
}

