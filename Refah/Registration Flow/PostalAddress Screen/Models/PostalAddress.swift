//
//  PostalAddress.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/7/23.
//

import Foundation

struct PostalAddress: Codable {
    let stateName: String
    let cityName: String
    let address: String
    
    private enum CodingKeys: String, CodingKey {
        case stateName = "state"
        case cityName = "city"
        case address
    }
}
