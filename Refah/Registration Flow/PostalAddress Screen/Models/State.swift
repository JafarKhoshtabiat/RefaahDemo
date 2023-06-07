//
//  State.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/6/23.
//

import Foundation

struct State: Codable {
    let id: Int
    let name: String
}

extension State: Equatable {
    static func ==(lhs: State, rhs: State) -> Bool {
        return lhs.id == rhs.id
    }
}
