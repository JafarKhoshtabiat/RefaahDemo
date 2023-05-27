//
//  OneTimeCodeViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import UIKit

protocol OneTimeCodeViewProtocol: RegistrationFlowView_NextButton_Protocol {
    var otcTextFieldDelegate: UITextFieldDelegate? { get set }
    var otcTextFieldEditingChangedDelegate: TextFieldEditingChangedDelegate? { get set }
    var otcTextFields: [UITextField] { get }
    
    func textFieldEditingChanged(_ textField: UITextField)
    func makeTextFieldFirstResponderWith(tag: Int)
    func setOTCTextFieldWith(tag: Int, text: String)
    func tapAction(_ sender:UITapGestureRecognizer)
}
