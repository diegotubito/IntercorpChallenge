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

extension String {
    func toDate(formato: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        
        let dateNSDate = dateFormatter.date(from: self)
        
        return dateNSDate
    }
}

extension Date {
    func toString(formato: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func age() -> Int {
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: self, to: Date(), options: [])
        let age = ageComponents.year!
        
        return age
    }
}
