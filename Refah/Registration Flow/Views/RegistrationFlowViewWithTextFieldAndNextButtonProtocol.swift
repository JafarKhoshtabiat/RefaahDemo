//
//  RegistrationFlowViewWithTextFieldAndNextButtonProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

protocol RegistrationFlowViewWithTextFieldAndNextButtonProtocol: RegistrationFlowViewWithNextButtonProtocol {
    var textField: UITextField { get }
    var placeholderText: String { get set }
    var textFieldDelegate: UITextFieldDelegate? { get set }
    var textFieldEditingChangedDelegate: TextFieldEditingChangedDelegate? { get set }
    
    func textFieldEditingChanged(_ textField: UITextField)
}
