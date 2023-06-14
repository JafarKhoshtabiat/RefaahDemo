//
//  LoginViewTextFieldsEditingChangedDelegate.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/10/23.
//

import UIKit

protocol LoginViewTextFieldsEditingChangedDelegate {
    func nationalCodeTextFieldEditingChanged(_ textField: UITextField)
    func passwordTextFieldEditingChanged(_ textField: UITextField)
}
