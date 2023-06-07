//
//  OneTimeCodeView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit

class OneTimeCodeView: RegistrationFlowView_NextButton {
    override var prompt: String {
        get {
            return "لطفا کد ۵رقمی پیامک‌شده را به درستی وارد نمائید."
        }
        set {}
    }
    var otcTextFieldDelegate: UITextFieldDelegate? {
        didSet {
            for otcTextField in self.otcTextFields {
                otcTextField.delegate = self.otcTextFieldDelegate
            }
        }
    }
    var otcTextFieldEditingChangedDelegate: TextFieldEditingChangedDelegate?
    var otcTextFields: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        for _ in 0...4 {
            let otcTextField = UITextField()
            self.otcTextFields.append(otcTextField)
            otcTextField.translatesAutoresizingMaskIntoConstraints = false
            otcTextField.textContentType = .oneTimeCode
            otcTextField.keyboardType = .asciiCapableNumberPad
            otcTextField.layer.cornerRadius = 5
            otcTextField.layer.borderWidth = 2
            otcTextField.layer.borderColor = UIColor.shadowMountain.cgColor
            otcTextField.backgroundColor = .white
            otcTextField.textAlignment = .center
            otcTextField.addTarget(self, action: #selector(self.textFieldEditingChanged), for: .editingChanged)
        }
        
        self.otcTextFields[0].tag = OTCTextFieldTag.otc0.rawValue
        self.otcTextFields[1].tag = OTCTextFieldTag.otc1.rawValue
        self.otcTextFields[2].tag = OTCTextFieldTag.otc2.rawValue
        self.otcTextFields[3].tag = OTCTextFieldTag.otc3.rawValue
        self.otcTextFields[4].tag = OTCTextFieldTag.otc4.rawValue
        let otc0TextField = self.otcTextFields[0]
        let otc1TextField = self.otcTextFields[1]
        let otc2TextField = self.otcTextFields[2]
        let otc3TextField = self.otcTextFields[3]
        let otc4TextField = self.otcTextFields[4]

        let otcsContainerView = UIView()
        otcsContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(otcsContainerView)
        let otcsContainerViewTopConstraint = NSLayoutConstraint(item: otcsContainerView, attribute: .top,
                                                                relatedBy: .equal,
                                                                toItem: self.promptLabel, attribute: .bottom,
                                                                multiplier: 1, constant: 90)
        let otcsContainerViewRightConstraint = NSLayoutConstraint(item: otcsContainerView, attribute: .right,
                                                                  relatedBy: .equal,
                                                                  toItem: self, attribute: .right,
                                                                  multiplier: 1, constant: -60)
        let otcsContainerViewHeightConstraint = NSLayoutConstraint(item: otcsContainerView, attribute: .height,
                                                                   relatedBy: .equal,
                                                                   toItem: nil, attribute: .height,
                                                                   multiplier: 0, constant: 50)
        let otcsContainerViewCenterXConstraint = NSLayoutConstraint(item: otcsContainerView, attribute: .centerX,
                                                                    relatedBy: .equal,
                                                                    toItem: self, attribute: .centerX,
                                                                    multiplier: 1, constant: 0)
        self.addConstraints([otcsContainerViewTopConstraint,
                             otcsContainerViewRightConstraint,
                             otcsContainerViewHeightConstraint,
                             otcsContainerViewCenterXConstraint])
        
        otcsContainerView.addSubview(otc0TextField)
        let otc0TextFieldLeftConstraint = NSLayoutConstraint(item: otc0TextField, attribute: .left,
                                                             relatedBy: .equal,
                                                             toItem: otcsContainerView, attribute: .left,
                                                             multiplier: 1, constant: 0)
        let otc0TextFieldHeightConstraint = NSLayoutConstraint(item: otc0TextField, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: otcsContainerView, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let otc0TextFieldWidthConstraint = NSLayoutConstraint(item: otc0TextField, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: nil, attribute: .width,
                                                              multiplier: 0, constant: 30)
        let otc0TextFieldCenterYConstarint = NSLayoutConstraint(item: otc0TextField, attribute: .centerY,
                                                                relatedBy: .equal,
                                                                toItem: otcsContainerView, attribute: .centerY,
                                                                multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc0TextFieldLeftConstraint,
                                          otc0TextFieldHeightConstraint,
                                          otc0TextFieldWidthConstraint,
                                          otc0TextFieldCenterYConstarint])
        
        otcsContainerView.addSubview(otc4TextField)
        let otc4TextFieldRightConstraint = NSLayoutConstraint(item: otc4TextField, attribute: .right,
                                                              relatedBy: .equal,
                                                              toItem: otcsContainerView, attribute: .right,
                                                              multiplier: 1, constant: 0)
        let otc4TextFieldHeightConstraint = NSLayoutConstraint(item: otc4TextField, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: otc0TextField, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let otc4TextFieldWidthConstraint = NSLayoutConstraint(item: otc4TextField, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: otc0TextField, attribute: .width,
                                                              multiplier: 1, constant: 0)
        let otc4TextFieldCenterYConstraint = NSLayoutConstraint(item: otc4TextField, attribute: .centerY,
                                                                relatedBy: .equal,
                                                                toItem: otc0TextField, attribute: .centerY,
                                                                multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc4TextFieldRightConstraint,
                                          otc4TextFieldHeightConstraint,
                                          otc4TextFieldWidthConstraint,
                                          otc4TextFieldCenterYConstraint])
        
        otcsContainerView.addSubview(otc2TextField)
        let otc2TextFieldHeightConstraint = NSLayoutConstraint(item: otc2TextField, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: otc0TextField, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let otc2TextFieldWidthConstraint = NSLayoutConstraint(item: otc2TextField, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: otc0TextField, attribute: .width,
                                                              multiplier: 1, constant: 0)
        let otc2TextFieldCenterYConstraint = NSLayoutConstraint(item: otc2TextField, attribute: .centerY,
                                                                relatedBy: .equal,
                                                                toItem: otc0TextField, attribute: .centerY,
                                                                multiplier: 1, constant: 0)
        let otc2TextFieldCenterXConstarint = NSLayoutConstraint(item: otc2TextField, attribute: .centerX,
                                                                relatedBy: .equal,
                                                                toItem: otcsContainerView, attribute: .centerX,
                                                                multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc2TextFieldHeightConstraint,
                                          otc2TextFieldWidthConstraint,
                                          otc2TextFieldCenterYConstraint,
                                          otc2TextFieldCenterXConstarint])
        
        let otc1ContainerView = UIView()
        otc1ContainerView.translatesAutoresizingMaskIntoConstraints = false
        otcsContainerView.addSubview(otc1ContainerView)
        let otc1ContainerViewTopConstarint = NSLayoutConstraint(item: otc1ContainerView, attribute: .top,
                                                                relatedBy: .equal,
                                                                toItem: otcsContainerView, attribute: .top,
                                                                multiplier: 1, constant: 0)
        let otc1ContainerViewRightConstraint = NSLayoutConstraint(item: otc1ContainerView, attribute: .right,
                                                                  relatedBy: .equal,
                                                                  toItem: otc2TextField, attribute: .left,
                                                                  multiplier: 1, constant: 0)
        let otc1ContainerViewBottomConstraint = NSLayoutConstraint(item: otc1ContainerView, attribute: .bottom,
                                                                   relatedBy: .equal,
                                                                   toItem: otcsContainerView, attribute: .bottom,
                                                                   multiplier: 1, constant: 0)
        let otc1ContainerViewLeftConstraint = NSLayoutConstraint(item: otc1ContainerView, attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: otc0TextField, attribute: .right,
                                                                 multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc1ContainerViewTopConstarint,
                                          otc1ContainerViewRightConstraint,
                                          otc1ContainerViewBottomConstraint,
                                          otc1ContainerViewLeftConstraint])
        
        otc1ContainerView.addSubview(otc1TextField)
        let otc1TextFieldHeightConstraint = NSLayoutConstraint(item: otc1TextField, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: otc0TextField, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let otc1TextFieldWidthConstraint = NSLayoutConstraint(item: otc1TextField, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: otc0TextField, attribute: .width,
                                                              multiplier: 1, constant: 0)
        let otc1TextFieldCenterYConstraint = NSLayoutConstraint(item: otc1TextField, attribute: .centerY,
                                                                relatedBy: .equal,
                                                                toItem: otc1ContainerView, attribute: .centerY,
                                                                multiplier: 1, constant: 0)
        let otc1TextFieldCenterXConstraint = NSLayoutConstraint(item: otc1TextField, attribute: .centerX,
                                                                relatedBy: .equal,
                                                                toItem: otc1ContainerView, attribute: .centerX,
                                                                multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc1TextFieldHeightConstraint,
                                          otc1TextFieldWidthConstraint,
                                          otc1TextFieldCenterYConstraint,
                                          otc1TextFieldCenterXConstraint])
        
        let otc3ContainerView = UIView()
        otc3ContainerView.translatesAutoresizingMaskIntoConstraints = false
        otcsContainerView.addSubview(otc3ContainerView)
        let otc3ContainerViewTopConstarint = NSLayoutConstraint(item: otc3ContainerView, attribute: .top,
                                                                relatedBy: .equal,
                                                                toItem: otcsContainerView, attribute: .top,
                                                                multiplier: 1, constant: 0)
        let otc3ContainerViewRightConstraint = NSLayoutConstraint(item: otc3ContainerView, attribute: .right,
                                                                  relatedBy: .equal,
                                                                  toItem: otc4TextField, attribute: .left,
                                                                  multiplier: 1, constant: 0)
        let otc3ContainerViewBottomConstraint = NSLayoutConstraint(item: otc3ContainerView, attribute: .bottom,
                                                                   relatedBy: .equal,
                                                                   toItem: otcsContainerView, attribute: .bottom,
                                                                   multiplier: 1, constant: 0)
        let otc3ContainerViewLeftConstraint = NSLayoutConstraint(item: otc3ContainerView, attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: otc2TextField, attribute: .right,
                                                                 multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc3ContainerViewTopConstarint,
                                          otc3ContainerViewRightConstraint,
                                          otc3ContainerViewBottomConstraint,
                                          otc3ContainerViewLeftConstraint])
        
        otc3ContainerView.addSubview(otc3TextField)
        let otc3TextFieldHeightConstraint = NSLayoutConstraint(item: otc3TextField, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: otc0TextField, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let otc3TextFieldWidthConstraint = NSLayoutConstraint(item: otc3TextField, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: otc0TextField, attribute: .width,
                                                              multiplier: 1, constant: 0)
        let otc3TextFieldCenterYConstraint = NSLayoutConstraint(item: otc3TextField, attribute: .centerY,
                                                                relatedBy: .equal,
                                                                toItem: otc3ContainerView, attribute: .centerY,
                                                                multiplier: 1, constant: 0)
        let otc3TextFieldCenterXConstraint = NSLayoutConstraint(item: otc3TextField, attribute: .centerX,
                                                                relatedBy: .equal,
                                                                toItem: otc3ContainerView, attribute: .centerX,
                                                                multiplier: 1, constant: 0)
        otcsContainerView.addConstraints([otc3TextFieldHeightConstraint,
                                          otc3TextFieldWidthConstraint,
                                          otc3TextFieldCenterYConstraint,
                                          otc3TextFieldCenterXConstraint])
                
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapAction (_:)))
        self.addGestureRecognizer(tapGesture)
    }
}

extension OneTimeCodeView: OneTimeCodeViewProtocol {
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        self.otcTextFieldEditingChangedDelegate?.editingChanged(textField)
    }
    
    func makeTextFieldFirstResponderWith(tag: Int) {
        switch tag {
        case OTCTextFieldTag.otc0.rawValue:
            self.otcTextFields[0].becomeFirstResponder()
        case OTCTextFieldTag.otc1.rawValue:
            self.otcTextFields[1].becomeFirstResponder()
        case OTCTextFieldTag.otc2.rawValue:
            self.otcTextFields[2].becomeFirstResponder()
        case OTCTextFieldTag.otc3.rawValue:
            self.otcTextFields[3].becomeFirstResponder()
        case OTCTextFieldTag.otc4.rawValue:
            self.otcTextFields[4].becomeFirstResponder()
        default:
            break
        }
    }
        
    func setOTCTextFieldWith(tag: Int, text: String) {
        switch tag {
        case OTCTextFieldTag.otc0.rawValue:
            self.otcTextFields[0].text = text
        case OTCTextFieldTag.otc1.rawValue:
            self.otcTextFields[1].text = text
        case OTCTextFieldTag.otc2.rawValue:
            self.otcTextFields[2].text = text
        case OTCTextFieldTag.otc3.rawValue:
            self.otcTextFields[3].text = text
        case OTCTextFieldTag.otc4.rawValue:
            self.otcTextFields[4].text = text
        default:
            break
        }
    }
    
    @objc func tapAction(_ sender:UITapGestureRecognizer) {
        for otcTextField in self.otcTextFields {
            if otcTextField.isFirstResponder {
                otcTextField.resignFirstResponder()
                break
            }
        }
    }
}

