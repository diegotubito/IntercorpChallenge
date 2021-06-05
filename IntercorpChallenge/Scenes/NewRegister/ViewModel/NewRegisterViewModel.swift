//
//  NewRegisterViewModel.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import Foundation
import Firebase

protocol NewRegisterViewModelProtocol {
    init(withView view: NewRegisterViewProtocol)
    
    func saveRegister(register: RegisterModel)
}

protocol NewRegisterViewProtocol {
    func showSuccess()
    func showError()
    func showLoading()
    func hideLoading()
}

class NewRegisterViewModel: NewRegisterViewModelProtocol {
    var view: NewRegisterViewProtocol!
    var model: NewRegisterModel!
    
    required init(withView view: NewRegisterViewProtocol) {
        self.view = view
        self.model = NewRegisterModel()
    }
    
    func saveRegister(register: RegisterModel) {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        let value = ["lastName": register.lastName,
                     "firstName": register.firstName,
                     "dateOfBirth": register.dateOfBirth] as [String : Any]
        view.showLoading()
        ref.child("users").childByAutoId().setValue(value) {
          (error:Error?, ref:DatabaseReference) in
            self.view.hideLoading()
            if error != nil {
            self.view.showError()
          } else {
            self.view.showSuccess()
          }
        }
    }
}
