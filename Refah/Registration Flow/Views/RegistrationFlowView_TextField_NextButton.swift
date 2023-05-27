//
//  RegistrationFlowView_TextField_NextButton.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

class RegistrationFlowView_TextField_NextButton: RegistrationFlowView_NextButton {
    let textField: UITextField = UITextField()
    var placeholderText = "عبارت پیش‌فرض"
    var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            self.textField.delegate = self.textFieldDelegate
        }
    }
    var textFieldEditingChangedDelegate: TextFieldEditingChangedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textField)
        let representiveCodeTextFieldTopConstraint = NSLayoutConstraint(item: self.textField, attribute: .top,
                                                                        relatedBy: .equal,
                                                                        toItem: promptLabel, attribute: .bottom,
                                                                        multiplier: 1, constant: 20)
        let representiveCodeTextFieldRightConstraint = NSLayoutConstraint(item: self.textField, attribute: .right,
                                                                          relatedBy: .equal,
                                                                          toItem: promptLabel, attribute: .right,
                                                                          multiplier: 1, constant: 0)
        let representiveCodeTextFieldCenterXConstraint = NSLayoutConstraint(item: self.textField, attribute: .centerX,
                                                                            relatedBy: .equal,
                                                                            toItem: self, attribute: .centerX,
                                                                            multiplier: 1, constant: 0)
        let representiveCodeTextFieldHeightConstraint = NSLayoutConstraint(item: self.textField, attribute: .height,
                                                                           relatedBy: .equal,
                                                                           toItem: nil, attribute: .height,
                                                                           multiplier: 0, constant: 50)
        self.addConstraints([representiveCodeTextFieldTopConstraint,
                             representiveCodeTextFieldRightConstraint,
                             representiveCodeTextFieldCenterXConstraint,
                             representiveCodeTextFieldHeightConstraint])
        self.textField.font = UIFont.systemFont(ofSize: 14)
        self.textField.placeholder = self.placeholderText
        self.textField.textAlignment = .left
        self.textField.layer.borderWidth = 2
        self.textField.layer.borderColor = UIColor.shadowMountain?.cgColor
        self.textField.layer.cornerRadius = 20
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: 2.0))
        self.textField.leftView = paddingView
        self.textField.leftViewMode = .always
        self.textField.rightView = paddingView
        self.textField.rightViewMode = .always
        self.textField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
    }
}

extension RegistrationFlowView_TextField_NextButton: RegistrationFlowView_TextField_NextButton_Protocol {
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        self.textFieldEditingChangedDelegate?.editingChanged(textField)
    }
}
