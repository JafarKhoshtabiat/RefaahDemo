//
//  PhoneNumberView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit

class PhoneNumberView: RegistrationFlowView_TextField_ValidatoinLabel_NextButton {
    override var prompt: String {
        get {
            return "لطفا شماره موبایل خود را به درستی در کادر زیر وارد نمائید."
        }
        set {}
    }
    override var placeholderText: String {
        get {
            return "09123456789"
        }
        set {}
    }
    override var isValidText: String {
        get {
            return "شماره موبایل معتبر است."
        }
        set {}
    }
    override var isNotValidText: String {
        get {
            return "شماره موبایل معتبر نیست."
        }
        set {}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.textField.textContentType = .telephoneNumber
        self.textField.keyboardType = .asciiCapableNumberPad
    }
}

extension PhoneNumberView: PhoneNumberViewProtocol {
    func makeTextFieldFirstResponder() {
        self.textField.becomeFirstResponder()
    }
}
