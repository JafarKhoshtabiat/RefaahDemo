//
//  PostalAddressPickerViewDelegateAndDataSourceProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/6/23.
//

import UIKit

protocol PostalAddressPickerViewDelegateAndDataSourceProtocol where Self: UIPickerViewDelegate, Self: UIPickerViewDataSource, Self:  StatesOrCitiesRetrievalDelegateProtocol {
    func setPickingStatus(status: PickingStatus)
}
