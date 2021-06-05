//
//  RegisterListModel.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import Foundation

struct RegisterListModel {
    var items: [RegisterModel] = []
}

struct RegisterModel: Codable {
    var lastName: String
    var firstName: String
    var dateOfBirth: Double
}
