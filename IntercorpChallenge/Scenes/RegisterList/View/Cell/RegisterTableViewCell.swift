//
//  RegisterTableViewCell.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(register: RegisterModel) {
        titleLabel.text = register.lastName + ", " + register.firstName
        dobLabel.text = register.dateOfBirth.toDate1970.toString(formato: "dd-MM-yyyy")
        ageLabel.text = String(register.dateOfBirth.toDate1970.age()) + " años"
    }
}
