//
//  City.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/6/23.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let stateId: Int
}

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id && lhs.stateId == rhs.stateId
    }
}
