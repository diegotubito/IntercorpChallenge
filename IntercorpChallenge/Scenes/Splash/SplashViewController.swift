//
//  SplashViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import UIKit

class SplahViewController: UIViewController {
    override func viewDidLoad() {
        super .viewDidLoad()
        AuthManager.shared.listenAuthChanges()
    }
}
