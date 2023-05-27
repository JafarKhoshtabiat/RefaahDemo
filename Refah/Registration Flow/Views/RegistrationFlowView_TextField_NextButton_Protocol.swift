//
//  RegistrationFlowView_TextField_NextButton_Protocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

protocol RegistrationFlowView_TextField_NextButton_Protocol: RegistrationFlowView_NextButton_Protocol {
    var textField: UITextField { get }
    var placeholderText: String { get set }
    var textFieldDelegate: UITextFieldDelegate? { get set }
    var textFieldEditingChangedDelegate: TextFieldEditingChangedDelegate? { get set }
    
    func textFieldEditingChanged(_ textField: UITextField)
}
