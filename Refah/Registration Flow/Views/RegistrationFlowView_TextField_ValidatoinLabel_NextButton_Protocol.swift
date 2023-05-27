//
//  RegistrationFlowView_TextField_ValidatoinLabel_NextButton_Protocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit

protocol RegistrationFlowView_TextField_ValidatoinLabel_NextButton_Protocol: RegistrationFlowView_TextField_NextButton_Protocol {
    var validationLabel: UILabel { get }
    var isValidText: String { get set }
    var isNotValidText: String { get set }
    
    func showValidationLabel(isValid: Bool)
    func hideValidationLabel()
}
