//
//  PostalAddressViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/7/23.
//

import Foundation

protocol PostalAddressViewProtocol: RegistrationFlowView_TextField_ValidatoinLabel_NextButton_Protocol {
    var postalAddressButtonsTouchUpInsideDelegate: PostalAddressButtonsTouchUpInsideDelegate? { get set }
    var pickerViewDelegateAndDataSource: PostalAddressPickerViewDelegateAndDataSourceProtocol? { get set }
    
    func resetCityNameLabel()
    func showShadowView()
    func hideShadowView()
    func startAnimatingActivityIndicator()
    func stopAnimatingActivityIndicator()
    func showPickerView()
    func hidePickerView()
    func reloadPickerView()
    func showConfirmButton()
    func hideConfirmButton()
    func getSelectedRowInPickerView() -> Int
    func selectPickerViewWith(index: Int)
    func setStateNameLabelTo(stateName: String)
    func setCityNameLabelTo(cityName: String)
}
