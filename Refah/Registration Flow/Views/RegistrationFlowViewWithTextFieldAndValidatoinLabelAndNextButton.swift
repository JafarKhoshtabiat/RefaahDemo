//
//  RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButton.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit
                                                                        
class RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButton: RegistrationFlowViewWithTextFieldAndNextButton {
    let validationLabel = UILabel()
    var isValidText = "پیش‌فرض معتبر"
    var isNotValidText = "پیش‌فرض نامعتبر"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.validationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(validationLabel)
        self.validationLabel.font = UIFont.systemFont(ofSize: 12)
        self.validationLabel.textAlignment = .right
        self.validationLabel.numberOfLines = 1
        self.validationLabel.isHidden = true
        let validationLabelTopConstraint = NSLayoutConstraint(item: self.validationLabel, attribute: .top,
                                                              relatedBy: .equal,
                                                              toItem: self.textField, attribute: .bottom,
                                                              multiplier: 1, constant: 20)
        let validationLabelRightConstraint = NSLayoutConstraint(item: self.validationLabel, attribute: .right,
                                                                relatedBy: .equal,
                                                                toItem: self.textField, attribute: .right,
                                                                multiplier: 1, constant: 0)
        self.addConstraints([validationLabelTopConstraint, validationLabelRightConstraint])
    }
}

extension RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButton: RegistrationFlowViewWithTextFieldAndValidatoinLabelAndNextButtonProtocol {
    func showValidationLabel(isValid: Bool) {
        if isValid {
            self.validationLabel.text = self.isValidText
            self.validationLabel.textColor = UIColor.herbal
            self.validationLabel.isHidden = false
        } else {
            self.validationLabel.text = self.isNotValidText
            self.validationLabel.textColor = UIColor.flameHawkfish
            self.validationLabel.isHidden = false
        }
    }
    
    func hideValidationLabel() {
        self.validationLabel.isHidden = true
    }
}
