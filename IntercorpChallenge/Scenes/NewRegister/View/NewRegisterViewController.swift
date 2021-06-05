//
//  CreateRegisterViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import UIKit

class NewRegisterViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    var viewModel: NewRegisterViewModelProtocol!
    var alert: DDAlert!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "New Register"
        alert = DDAlert()
        viewModel = NewRegisterViewModel(withView: self)
    }
    
    
    @IBAction func saveButtonDidPressed(_ sender: Any) {
        guard let lastName = lastNameTextfield.text,
              let firstName = firstNameTextfield.text,
              !lastName.isEmpty, !firstName.isEmpty
        else {
            alert.SingleButton(title: "Error", body: "We need last name and first name to save", buttonTitle: "OK")
            return
        }
        
        let newRegister = RegisterModel(lastName: lastName,
                                        firstName: firstName,
                                        dateOfBirth: datePicker.date.timeIntervalSince1970)
        viewModel.saveRegister(register: newRegister)
    }
}

extension NewRegisterViewController: NewRegisterViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showSuccess() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.alert.SingleButton(title: "Error", body: "Saving register error", buttonTitle: "Ok") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
