//
//  AppDelegate.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AuthManager.shared.listenAuthChanges()
        addObservers()
  
        return true
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLoginHandler), name: .DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(neeToLoginHandler), name: .NeedLogin, object: nil)
    }
    
    @objc func neeToLoginHandler() {
        Router.routeToLogin(window: &window)
    }
    
    @objc func didLoginHandler() {
        Router.routeToHome(window: &self.window)
    }
}

