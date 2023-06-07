//
//  StatesOrCitiesRetrievalDelegateProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/6/23.
//

import Foundation

protocol StatesOrCitiesRetrievalDelegateProtocol {
    func statesRetrieved(states: [State])
    func citiesRetirieved(cities: [City])
}
