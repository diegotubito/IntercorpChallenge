//
//  RegisterListViewModel.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import Foundation
import Firebase

protocol RegisterListViewModelProtocol {
    init(withView view: RegisterListViewProtocol)
    
    func loadRegisters()
    func getItems() -> [RegisterModel]
}

protocol RegisterListViewProtocol {
    func showSuccess()
    func showError(_ message: String)
}

class RegisterListViewModel: RegisterListViewModelProtocol {
    var view: RegisterListViewProtocol!
    var model: RegisterListModel!
    
    required init(withView view: RegisterListViewProtocol) {
        self.view = view
        model = RegisterListModel()
    }
    
    func loadRegisters() {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        ref.child("users").getData { (error, snapshot) in
            if let error = error {
                self.view.showError("Error getting data \(error.localizedDescription)")
            } else if snapshot.exists() {
                guard let firebaseData = snapshot.value as? NSDictionary else { return }
                var dictionaryItems: [[String: Any]] = []
                
                for (_, value) in firebaseData {
                    if let register = value as? [String: Any] {
                        dictionaryItems.append(register)
                    }
                }
                guard
                    let data = try? JSONSerialization.data(withJSONObject: dictionaryItems, options: []),
                    let registers = try? JSONDecoder().decode([RegisterModel].self, from: data) else {
                    self.view.showError("serialization error")
                    
                    return
                }
                
                self.model.items = registers
                self.view.showSuccess()
            } else {
                self.view.showError("no data available")
            }
        }
    }
    
    func getItems() -> [RegisterModel] {
        return model.items
    }
}
