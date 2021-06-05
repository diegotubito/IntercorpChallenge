//
//  FirebaseModel.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import Foundation

struct FirebaseUserModel: Decodable, Encodable {
    var token : String?
    var username : String?
    var exp : Double?
    var uid : String!
    var displayName : String?
    var email : String?
    var emailVerified : Bool?
    var phoneNumber : String?
    var photoURL : String?
    var lastLoginAt : String?
    var createdAt : String?
}
