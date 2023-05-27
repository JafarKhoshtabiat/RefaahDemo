//
//  RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButtonProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit

protocol RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButtonProtocol: RegistrationFlowViewWithTextFieldAndNextButtonProtocol {
    var validationLabel: UILabel { get }
    var isValidText: String { get set }
    var isNotValidText: String { get set }
    
    func showValidationLabel(isValid: Bool)
    func hideValidationLabel()
}
