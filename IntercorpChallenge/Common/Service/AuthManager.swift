//
//  Authentication.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import Foundation
import Firebase

open class AuthManager {
    static public let shared = AuthManager()
    static private var authListener : AuthStateDidChangeListenerHandle!
    static public var userData : User?
    
    public func listenAuthChanges() {
        AuthManager.authListener = Auth.auth().addStateDidChangeListener() { auth, user in
            AuthManager.userData = user
            guard let user = user else {
                print("no user logged in")
                NotificationCenter.default.post(name: .NeedLogin, object: nil)
                return
            }
            
            user.reload { (error) in
                guard error == nil else {
                    print("some error ocurred reloading user firebase auth")
                    return
                }
                print("login")
                NotificationCenter.default.post(name: .DidLogin, object: nil)
            }
        }
    }
    
    
    public func registerNewUser(email: String, password: String, success: @escaping (AuthDataResult?) -> Void, fail: @escaping (Error) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                fail(error!)
                return
            }
            success(user)
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
    
    public func getUserByEmail(email: String, success: @escaping ([String]?) -> Void, fail: @escaping (Error?) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (response, error) in
            guard error == nil else {
                fail(error!)
                return
            }
            guard let response = response else {
                fail(nil)
                return
            }
            
            success(response)
        }
    }
}
