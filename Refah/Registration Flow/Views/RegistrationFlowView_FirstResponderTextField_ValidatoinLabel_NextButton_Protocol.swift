//
//  RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import Foundation

protocol RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol: RegistrationFlowView_TextField_ValidatoinLabel_NextButton_Protocol {
    func makeTextFieldFirstResponder()
}

extension RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol {
    func makeTextFieldFirstResponder() {
        self.textField.becomeFirstResponder()
    }
}
