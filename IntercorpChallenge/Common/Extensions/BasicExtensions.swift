//
//  DoubleExtension.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import Foundation

extension Double {
    var toDate1970 : Date {
        return Date(timeIntervalSince1970: self)
    }
}

extension Notification.Name {
    static let NeedLogin = Notification.Name("NeedLogin")
    static let TokenExpired = Notification.Name("TokenExpired")
    static let DidLogin = Notification.Name("DidLogin")
}
