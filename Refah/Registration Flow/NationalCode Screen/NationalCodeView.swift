//
//  NationalCodeView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import Foundation

class NationalCodeView: RegistrationFlowView_TextField_ValidatoinLabel_NextButton {
    override var prompt: String {
        get {
            return "لطفا کدملی خود را به درستی در کادر زیر وارد نمائید."
        }
        set {}
    }
    override var placeholderText: String {
        get {
            return "کدملی"
        }
        set {}
    }
    override var isValidText: String {
        get {
            return "کدملی معتبر است."
        }
        set {}
    }
    override var isNotValidText: String {
        get {
            return "کدملی معتبر نیست."
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
        self.textField.keyboardType = .asciiCapableNumberPad
    }
}

extension NationalCodeView: RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol {
    
}
