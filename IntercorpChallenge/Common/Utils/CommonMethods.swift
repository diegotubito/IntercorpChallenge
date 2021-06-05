//
//  CommonMethods.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 05/06/2021.
//

import Foundation

public func removeKeys(source: [String: Any]) -> [[String: Any]] {
    var result: [[String: Any]] = []
    for (_, value) in source {
        if let register = value as? [String: Any] {
            result.append(register)
        }
    }
    
    return result
}

