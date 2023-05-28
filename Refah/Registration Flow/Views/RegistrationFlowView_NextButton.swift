//
//  RegistrationFlowView_NextButton.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

class RegistrationFlowView_NextButton: UIView {
    var flowNextDelegate: RegistrationFlowNextDelegate?
    let createAccountLabel = UILabel()
    var prompt = "متن پیش‌فرض"
    let promptLabel = UILabel()
    let nextButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.backgroundColor = UIColor.antiFlashWhite
        
        self.createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.createAccountLabel)
        self.createAccountLabel.text = "ساخت حساب کاربری"
        self.createAccountLabel.font = UIFont.systemFont(ofSize: 18)
        self.createAccountLabel.textAlignment = .center
        self.createAccountLabel.numberOfLines = 1
        let createAccountLabelTopConstraint = NSLayoutConstraint(item: self.createAccountLabel, attribute: .top,
                                                                 relatedBy: .equal,
                                                                 toItem: self, attribute: .top, multiplier: 1, constant: 20)
        let createAccountLabelCenterXConstraint = NSLayoutConstraint(item: self.createAccountLabel, attribute: .centerX,
                                                                     relatedBy: .equal,
                                                                     toItem: self, attribute: .centerX,
                                                                     multiplier: 1, constant: 0)
        self.addConstraints([createAccountLabelTopConstraint, createAccountLabelCenterXConstraint])
        
        self.promptLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.promptLabel)
        self.promptLabel.text = self.prompt
        self.promptLabel.textColor = UIColor.extinctVolcano
        self.promptLabel.font = UIFont.systemFont(ofSize: 14)
        self.promptLabel.textAlignment = .right
        self.promptLabel.numberOfLines = 1
        let promptLabelTopConstraint = NSLayoutConstraint(item: self.promptLabel, attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: self.createAccountLabel, attribute: .bottom,
                                                          multiplier: 1, constant: 30)
        let promptLabelRightConstraint = NSLayoutConstraint(item: self.promptLabel, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self, attribute: .right,
                                                            multiplier: 1, constant: -30)
        let promptLabelCenterXConstraint = NSLayoutConstraint(item: self.promptLabel, attribute: .centerX,
                                                              relatedBy: .equal,
                                                              toItem: self, attribute: .centerX,
                                                              multiplier: 1, constant: 0)
        self.addConstraints([promptLabelTopConstraint, promptLabelRightConstraint, promptLabelCenterXConstraint])
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.nextButton)
        let nextButtonRightConstraint = NSLayoutConstraint(item: self.nextButton, attribute: .right,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .right,
                                                           multiplier: 1, constant: -30)
        let nextButtonBottomConstraint = NSLayoutConstraint(item: self.nextButton, attribute: .bottom,
                                                            relatedBy: .equal,
                                                            toItem: self, attribute: .bottom,
                                                            multiplier: 1, constant: -60)
        let nextButtonHeightConstraint = NSLayoutConstraint(item: self.nextButton, attribute: .height,
                                                            relatedBy: .equal,
                                                            toItem: nil, attribute: .height,
                                                            multiplier: 0, constant: 50)
        let nextButtonCenterXConstraint = NSLayoutConstraint(item: self.nextButton, attribute: .centerX,
                                                             relatedBy: .equal,
                                                             toItem: self, attribute: .centerX,
                                                             multiplier: 1, constant: 0)
        self.addConstraints([nextButtonRightConstraint,
                             nextButtonBottomConstraint,
                             nextButtonHeightConstraint,
                             nextButtonCenterXConstraint])
        self.nextButton.backgroundColor = UIColor.carnival
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.setTitle("مرحله بعد", for: .normal)
        self.nextButton.setTitleColor(UIColor.white, for: .normal)
        self.nextButton.addTarget(self, action: #selector(self.nextButtonTouchUpInside), for: .touchUpInside)
    }
}

extension RegistrationFlowView_NextButton: RegistrationFlowView_NextButton_Protocol {
    @objc func nextButtonTouchUpInside() {
        self.flowNextDelegate?.next()
    }
}
