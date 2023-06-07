//
//  PostalAddressPickerViewDelegateAndDataSource.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/6/23.
//

import UIKit

class PostalAddressPickerViewDelegateAndDataSource: NSObject {
    private var states: [State]?
    private var cities: [City]?
    private var pickingStatus: PickingStatus = .none
}

extension PostalAddressPickerViewDelegateAndDataSource: PostalAddressPickerViewDelegateAndDataSourceProtocol {
    func setPickingStatus(status: PickingStatus) {
        self.pickingStatus = status
    }
}

extension PostalAddressPickerViewDelegateAndDataSource: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.pickingStatus {
        case .states:
            return self.states?[row].name
        case .cities:
            return self.cities?[row].name
        case .none:
            return nil
        }
    }
}

extension PostalAddressPickerViewDelegateAndDataSource: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickingStatus {
        case .states:
            return self.states?.count ?? 0
        case .cities:
            return self.cities?.count ?? 0
        case .none:
            return 0
        }
    }
}

extension PostalAddressPickerViewDelegateAndDataSource: StatesOrCitiesRetrievalDelegateProtocol {
    func statesRetrieved(states: [State]) {
        self.states = states
    }
    
    func citiesRetirieved(cities: [City]) {
        self.cities = cities
    }
}
