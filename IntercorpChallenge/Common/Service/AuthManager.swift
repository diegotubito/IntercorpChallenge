//
//  Authentication.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import Foundation
import Firebase

class AuthManager {
    static public let shared = AuthManager()
    static private var authListener : AuthStateDidChangeListenerHandle!
    static public var userData : User?
    
    public func listenAuthChanges() {
        AuthManager.authListener = Auth.auth().addStateDidChangeListener() { auth, user in
            AuthManager.userData = user
            guard let user = user else {
                NotificationCenter.default.post(name: .NeedLogin, object: nil)
                return
            }
            
            user.reload { (error) in
                guard error == nil else {
                    print("some error ocurred reloading user firebase auth")
                    return
                }
                NotificationCenter.default.post(name: .DidLogin, object: nil)
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
    
    public func signInWithEmail(email: String, password: String, success: @escaping (AuthDataResult?) -> Void, fail: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (usuario, error) in
            guard error == nil else {
                fail(error!)
                return
            }
            
            success(usuario)
        }
    }
}
