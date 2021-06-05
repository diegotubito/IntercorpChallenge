//
//  Router.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit

class Router {
    static let shared = Router()
    
    static func routeToHome(window: inout UIWindow?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterListViewController") as! RegisterListViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    static func routeToLogin(window: inout UIWindow?) {
        //let bundle = Bundle(for: LoginVerifyEmail.self)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    
}


