//
//  PhoneNumberViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import Foundation

protocol PhoneNumberViewProtocol: RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButtonProtocol {
    func makeTextFieldFirstResponder()
}
