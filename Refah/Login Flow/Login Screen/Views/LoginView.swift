//
//  LoginView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/8/23.
//

import UIKit

class LoginView: UIView {
    private var faraRefaahImageView: UIImageView!
    private var containcerView: UIView!
    private var nationalCodeLabel: UILabel!
    private var nationalCodeTextField: UITextField!
    private var passwordLabel: UILabel!
    private var passwordTextField: UITextField!
    private var showPasswordButton: UIButton!
    private var loginButton: UIButton!
    private var forgetPasswordButton: UIButton!
    private var fingerPrintButton: UIButton!
    var shadowView: UIView!
    var textFieldsEditingChangedDelegate: LoginViewTextFieldsEditingChangedDelegate?
    var textFieldsDelegate: UITextFieldDelegate? {
        didSet {
            self.nationalCodeTextField.delegate = self.textFieldsDelegate
            self.passwordTextField.delegate = self.textFieldsDelegate
        }
    }
    var buttonsTouchUpInsideDelegate: LoginViewButtonsTouchUpInsideDelegate?
    private var pendingView: UIView!
    private var firstPendingView: UIView!
    private var firstImageView: UIImageView!
    private var firstActivityIndicator: UIActivityIndicatorView!
    private var secondPendingView: UIView!
    private var secondImageView: UIImageView!
    private var secondActivityIndicator: UIActivityIndicatorView!
    private var thirdPendingView: UIView!
    private var thirdImageView: UIImageView!
    private var thirdActivityIndicator: UIActivityIndicatorView!
    private var firstLineView: UIView!
    private var secondLineView: UIView!
    private var firstLabel: UILabel!
    private var secondLabel: UILabel!
    private var thirdLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.backgroundColor = UIColor.jupiter
        
        self.faraRefaahImageView = self.createImageViewWith(imageName: "FaraRefah_Login")
        self.addSubview(self.faraRefaahImageView)
        let faraRefaahImageViewConstraints = self.faraRefaahLoginImageViewConstraints()
        self.addConstraints(faraRefaahImageViewConstraints)
        
        self.containcerView = self.createView(backgroundColor: .white, cornerRadius: 20)
        self.addSubview(self.containcerView)
        let containcerViewConstraints = self.containerViewConstraints()
        self.addConstraints(containcerViewConstraints)
        
        self.nationalCodeLabel = self.createLabel(text: "کدملی",
                                                  color: .extinctVolcano,
                                                  font: UIFont.systemFont(ofSize: 14),
                                                  alignment: .right)
        self.containcerView.addSubview(self.nationalCodeLabel)
        let nationalCodeLabelConstraints = self.nationalCodeLabelConstraints()
        self.containcerView.addConstraints(nationalCodeLabelConstraints)
            
        self.nationalCodeTextField = self.createTextField(placeholder: "کدملی",
                                                          editingChangedHandlerSelector: #selector(self.nationalCodeTextFieldEditingChanged),
                                                          keyboardType: .asciiCapableNumberPad,
                                                          contentType: nil,
                                                          tag: LoginScreenTextFieldTag.nationalCodeTextFieldTag.rawValue)
        self.containcerView.addSubview(self.nationalCodeTextField)
        let nationalCodeTextFieldConstraints = self.nationalCodeTextFieldConstraints()
        self.containcerView.addConstraints(nationalCodeTextFieldConstraints)
        
        self.passwordLabel = self.createLabel(text: "کلمه عبور",
                                              color: .extinctVolcano,
                                              font: UIFont.systemFont(ofSize: 14),
                                              alignment: .right)
        self.containcerView.addSubview(self.passwordLabel)
        let passwordLabelConstraints = self.passwordLabelConstraints()
        self.containcerView.addConstraints(passwordLabelConstraints)
        
        self.passwordTextField = self.createTextField(placeholder: "کلمه عبور",
                                                      editingChangedHandlerSelector: #selector(self.passwordTextFieldEditingChanged),
                                                      keyboardType: .asciiCapable,
                                                      contentType: .password,
                                                      tag: LoginScreenTextFieldTag.passwordTextFieldTag.rawValue)
        self.passwordTextField.isSecureTextEntry = true
        self.containcerView.addSubview(self.passwordTextField)
        let passwordTextFieldConstraints = self.passwordTextFieldConstraints()
        self.containcerView.addConstraints(passwordTextFieldConstraints)
        
        self.showPasswordButton = self.createButtonWithImage(image: UIImage(named: "ShowPassword"),
                                                             touchUpInsideHandlerSelector: #selector(self.showPasswordButtonTouchUpInside))
        self.containcerView.addSubview(self.showPasswordButton)
        let showPasswordButtonConstraints = self.showPasswordButtonConstraints()
        self.containcerView.addConstraints(showPasswordButtonConstraints)
        
        self.loginButton = self.createButton(title: "ورود", touchUpInsideHandler: #selector(self.loginButtonTouchUpInside))
        self.containcerView.addSubview(self.loginButton)
        let loginButtonConstraints = self.loginButtonConstraints()
        self.containcerView.addConstraints(loginButtonConstraints)
        
        self.forgetPasswordButton = self.createButtonWithAttributedText(title: "فراموشی رمز عبور",
                                                                        color: UIColor.blueAnthracite,
                                                                        touchUpInsideHandlerSelector: #selector(self.forgetPasswordButtonTouchUpInside))
        self.containcerView.addSubview(self.forgetPasswordButton)
        let forgetPasswordButtonConstraints = self.forgetPasswordButtonConstraints()
        self.containcerView.addConstraints(forgetPasswordButtonConstraints)
        
        self.fingerPrintButton = self.createButtonWithImage(image: UIImage(named: "FingerPrint"),
                                                            touchUpInsideHandlerSelector: #selector(self.fingerPrintButtonTouchUpInside))
        self.containcerView.addSubview(self.fingerPrintButton)
        let fingerPrintButtonConstraints = self.fingerPrintButtonConstraints()
        self.containcerView.addConstraints(fingerPrintButtonConstraints)
        
        self.createShadowView()
        
        self.pendingView = self.createView(backgroundColor: .white, cornerRadius: 15)
        self.addSubview(self.pendingView)
        let pendingViewConstraints = self.pendingViewConstraints()
        self.addConstraints(pendingViewConstraints)
        self.pendingView.isHidden = true
        
        self.firstPendingView = self.createView(backgroundColor: .clear)
        self.pendingView.addSubview(self.firstPendingView)
        let firstPendingViewConstraints = self.firstPendingViewConstraints()
        self.pendingView.addConstraints(firstPendingViewConstraints)
        
        self.secondPendingView = self.createView(backgroundColor: .clear)
        self.pendingView.addSubview(self.secondPendingView)
        let secondPendingViewConstraints = self.secondPendingViewConstraints()
        self.pendingView.addConstraints(secondPendingViewConstraints)
        
        self.thirdPendingView = self.createView(backgroundColor: .clear)
        self.pendingView.addSubview(self.thirdPendingView)
        let thirdPendingViewConstraints = self.thirdPendingViewConstraints()
        self.pendingView.addConstraints(thirdPendingViewConstraints)
        
        self.firstLineView = self.createView(backgroundColor: .lavendarWisp)
        self.pendingView.addSubview(self.firstLineView)
        let firstLineViewConstraints = self.firstLineViewConstraints()
        self.pendingView.addConstraints(firstLineViewConstraints)
        
        self.secondLineView = self.createView(backgroundColor: .lavendarWisp)
        self.pendingView.addSubview(self.secondLineView)
        let secondLineViewConstraints = self.secondLineViewConstraints()
        self.pendingView.addConstraints(secondLineViewConstraints)
        
        self.firstActivityIndicator = self.createActivityIndicator()
        self.pendingView.addSubview(self.firstActivityIndicator)
        let firstActivityIndicatorConstraints = self.firstActivityIndicatorConstraints()
        self.pendingView.addConstraints(firstActivityIndicatorConstraints)
//        self.firstActivityIndicator.startAnimating()
        
        self.secondActivityIndicator = self.createActivityIndicator()
        self.pendingView.addSubview(self.secondActivityIndicator)
        let secondActivityIndicatorConstraints = self.secondActivityIndicatorConstraints()
        self.pendingView.addConstraints(secondActivityIndicatorConstraints)
//        self.secondActivityIndicator.startAnimating()
        
        self.thirdActivityIndicator = self.createActivityIndicator()
        self.pendingView.addSubview(self.thirdActivityIndicator)
        let thirdActivityIndicatorConstraints = self.thirdActivityIndicatorConstraints()
        self.pendingView.addConstraints(thirdActivityIndicatorConstraints)
//        self.thirdActivityIndicator.startAnimating()
        
        self.firstLabel = self.createLabel(text: "احراز هویت و ورود",
                                           color: .kingCreekFalls,
                                           font: UIFont.systemFont(ofSize: 17),
                                           alignment: .right)
        self.pendingView.addSubview(self.firstLabel)
        let firstLabelConstraints = self.firstLabelConstraints()
        self.pendingView.addConstraints(firstLabelConstraints)
        
        self.secondLabel = self.createLabel(text: "دریافت اطلاعات حساب",
                                            color: .kingCreekFalls,
                                            font: UIFont.systemFont(ofSize: 17),
                                            alignment: .right)
        self.pendingView.addSubview(self.secondLabel)
        let secondLabelConstraints = self.secondLabelConstraints()
        self.pendingView.addConstraints(secondLabelConstraints)
        
        self.thirdLabel = self.createLabel(text: "دریافت اطلاعات کارت",
                                           color: .kingCreekFalls,
                                           font: UIFont.systemFont(ofSize: 17),
                                           alignment: .right)
        self.pendingView.addSubview(self.thirdLabel)
        let thirdLabelConstraints = self.thirdLabelConstraints()
        self.pendingView.addConstraints(thirdLabelConstraints)
        
        self.firstImageView = self.createImageViewWith(imageName: "GreenTic_47_42")
        self.pendingView.addSubview(self.firstImageView)
        let firstImageViewConstraints = self.firstImageViewConstraints()
        self.pendingView.addConstraints(firstImageViewConstraints)
        self.firstImageView.isHidden = true
        
        self.secondImageView = self.createImageViewWith(imageName: "GreenTic_47_42")
        self.pendingView.addSubview(self.secondImageView)
        let secondImageViewConstraints = self.secondImageViewConstraints()
        self.pendingView.addConstraints(secondImageViewConstraints)
        self.secondImageView.isHidden = true
        
        self.thirdImageView = self.createImageViewWith(imageName: "GreenTic_47_42")
        self.pendingView.addSubview(self.thirdImageView)
        let thirdImageViewConstraints = self.thirdImageViewConstraints()
        self.pendingView.addConstraints(thirdImageViewConstraints)
        self.thirdImageView.isHidden = true
    }
}

extension LoginView {
    private func createImageViewWith(imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func faraRefaahLoginImageViewConstraints() -> [NSLayoutConstraint] {
        let imageView: UIImageView = self.faraRefaahImageView
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self, attribute: .top,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: imageView, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1, constant: 0)
        
        return [topConstraint,
                rightConstraint,
                leftConstraint]
    }
    
    private func createView(backgroundColor: UIColor, cornerRadius: CGFloat = 0) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        return view
    }
    
    private func containerViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.containcerView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self, attribute: .top,
                                               multiplier: 1, constant: 160)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self, attribute: .right,
                                                 multiplier: 1, constant: -16)
//        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom,
//                                                  relatedBy: .equal,
//                                                  toItem: self, attribute: .bottom,
//                                                  multiplier: 1, constant: -160)
//        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom,
//                                                  relatedBy: .equal,
//                                                  toItem: self.fingerPrintButton, attribute: .bottom,
//                                                  multiplier: 1, constant: 24)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        
        return [topConstraint,
                rightConstraint,
//                bottomConstraint,
                centerXConstraint]
    }
    
    private func createLabel(text: String, color: UIColor, font: UIFont, alignment: NSTextAlignment, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = UIColor.extinctVolcano
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 1
        
        return label
    }
    
    private func nationalCodeLabelConstraints() -> [NSLayoutConstraint] {
        let label: UILabel = self.nationalCodeLabel
        let topConstraint = NSLayoutConstraint(item: label, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.containcerView, attribute: .top,
                                               multiplier: 1, constant: 24)
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.containcerView, attribute: .right,
                                                 multiplier: 1, constant: -24)
        return [topConstraint,
                rightConstraint]
    }
    
    private func createTextField(placeholder: String,
                                 editingChangedHandlerSelector: Selector,
                                 keyboardType: UIKeyboardType,
                                 contentType: UITextContentType?,
                                 tag: Int = 10000) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = placeholder
        textField.textAlignment = .left
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.shadowMountain.cgColor
        textField.layer.cornerRadius = 20
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: 2.0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
        textField.addTarget(self, action: editingChangedHandlerSelector, for: .editingChanged)
        textField.keyboardType = keyboardType
        textField.tag = tag
        return textField
    }
    
    private func nationalCodeTextFieldConstraints() -> [NSLayoutConstraint] {
        let textField: UITextField = self.nationalCodeTextField
        let topConstraint = NSLayoutConstraint(item: textField, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.nationalCodeLabel, attribute: .bottom,
                                               multiplier: 1, constant: 5)
        let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.nationalCodeLabel, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self, attribute: .height,
                                                  multiplier: 0, constant: 50)
        let centerXConstraint = NSLayoutConstraint(item: textField, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.containcerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func passwordLabelConstraints() -> [NSLayoutConstraint] {
        let label: UILabel = self.passwordLabel
        let topConstraint = NSLayoutConstraint(item: label, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.nationalCodeTextField, attribute: .bottom,
                                               multiplier: 1, constant: 10)
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.nationalCodeTextField, attribute: .right,
                                                 multiplier: 1, constant: 0)
        
        return [topConstraint,
                rightConstraint]
    }
    
    private func passwordTextFieldConstraints() -> [NSLayoutConstraint] {
        let textField: UITextField = self.passwordTextField
        let topConstraint = NSLayoutConstraint(item: textField, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.passwordLabel, attribute: .bottom,
                                               multiplier: 1, constant: 5)
        let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.passwordLabel, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.nationalCodeTextField, attribute: .height,
                                                  multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: textField, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.containcerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func createButtonWithImage(image: UIImage?, touchUpInsideHandlerSelector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.addTarget(self, action: touchUpInsideHandlerSelector, for: .touchUpInside)
        return button
    }
    
    private func showPasswordButtonConstraints() -> [NSLayoutConstraint] {
        let button: UIButton = self.showPasswordButton
        let rightConstraint = NSLayoutConstraint(item: button, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.passwordTextField, attribute: .right,
                                                 multiplier: 1, constant: -16)
        let centerYConstraint = NSLayoutConstraint(item: button, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.passwordTextField, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 36)
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil, attribute: .width,
                                                 multiplier: 0, constant: 36)
        return [rightConstraint,
                centerYConstraint,
                heightConstraint,
                widthConstraint]
    }
    
    private func createButton(title: String, touchUpInsideHandler: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.carnival
        button.layer.cornerRadius = 20
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: touchUpInsideHandler, for: .touchUpInside)
        return button
    }
    
    private func loginButtonConstraints() -> [NSLayoutConstraint] {
        let button: UIButton = self.loginButton
        let topConstraint = NSLayoutConstraint(item: button, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.passwordTextField, attribute: .bottom,
                                               multiplier: 1, constant: 36)
        let rightConstraint = NSLayoutConstraint(item: button, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.passwordTextField, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.passwordTextField, attribute: .height,
                                                  multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.containcerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func createButtonWithAttributedText(title: String, color: UIColor, touchUpInsideHandlerSelector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 12),
                                                         .foregroundColor: color,
                                                         .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: title,
                                                        attributes: attributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: touchUpInsideHandlerSelector, for: .touchUpInside)
        return button
    }
    
    private func forgetPasswordButtonConstraints() -> [NSLayoutConstraint] {
        let button: UIButton = self.forgetPasswordButton
        let topConstraint = NSLayoutConstraint(item: button, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.loginButton, attribute: .bottom,
                                               multiplier: 1, constant: 5)
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.containcerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                centerXConstraint]
    }
    
    private func fingerPrintButtonConstraints() -> [NSLayoutConstraint] {
        let button: UIButton = self.fingerPrintButton
        let topConstraint = NSLayoutConstraint(item: button, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.forgetPasswordButton, attribute: .bottom,
                                               multiplier: 1, constant: 24)
        let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self.containcerView, attribute: .bottom,
                                                  multiplier: 1, constant: -40)
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.containcerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                bottomConstraint,
                centerXConstraint]
    }
    
    private func pendingViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.pendingView
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self, attribute: .right,
                                                 multiplier: 1, constant: -20)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 180)
        let centerYConstraint = NSLayoutConstraint(item: view, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                heightConstraint,
                centerYConstraint,
                centerXConstraint]
    }
    
    private func firstPendingViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.firstPendingView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.pendingView, attribute: .top,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.pendingView, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.pendingView, attribute: .height,
                                                  multiplier: 1/3, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.pendingView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func secondPendingViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.secondPendingView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.firstPendingView, attribute: .bottom,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.pendingView, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.pendingView, attribute: .height,
                                                  multiplier: 1/3, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.pendingView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func thirdPendingViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.thirdPendingView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.secondPendingView, attribute: .bottom,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.pendingView, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self.pendingView, attribute: .bottom,
                                                  multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.pendingView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                bottomConstraint,
                centerXConstraint]
    }
    
    private func firstLineViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.firstLineView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.firstPendingView, attribute: .bottom,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.pendingView, attribute: .right,
                                                 multiplier: 1, constant: -16)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 2)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.pendingView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func secondLineViewConstraints() -> [NSLayoutConstraint] {
        let view: UIView = self.secondLineView
        let topConstraint = NSLayoutConstraint(item: view, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.secondPendingView, attribute: .bottom,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: view, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.firstLineView, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: self.firstLineView, attribute: .height,
                                                  multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: view, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.pendingView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [topConstraint,
                rightConstraint,
                heightConstraint,
                centerXConstraint]
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
    
    private func firstActivityIndicatorConstraints() -> [NSLayoutConstraint] {
        let ai: UIActivityIndicatorView = self.firstActivityIndicator
        let rightConstraint = NSLayoutConstraint(item: ai, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.firstPendingView, attribute: .right,
                                                 multiplier: 1, constant: -24)
        let centerYConstraint = NSLayoutConstraint(item: ai, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.firstPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func secondActivityIndicatorConstraints() -> [NSLayoutConstraint] {
        let ai: UIActivityIndicatorView = self.secondActivityIndicator
        let rightConstraint = NSLayoutConstraint(item: ai, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.firstActivityIndicator, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: ai, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.secondPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func thirdActivityIndicatorConstraints() -> [NSLayoutConstraint] {
        let ai: UIActivityIndicatorView = self.thirdActivityIndicator
        let rightConstraint = NSLayoutConstraint(item: ai, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.secondActivityIndicator, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: ai, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.thirdPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func firstLabelConstraints() -> [NSLayoutConstraint] {
        let label: UILabel = self.firstLabel
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.firstActivityIndicator, attribute: .left,
                                                 multiplier: 1, constant: -24)
        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.firstPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func secondLabelConstraints() -> [NSLayoutConstraint] {
        let label: UILabel = self.secondLabel
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.secondActivityIndicator, attribute: .left,
                                                 multiplier: 1, constant: -24)
        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.secondPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func thirdLabelConstraints() -> [NSLayoutConstraint] {
        let label: UILabel = self.thirdLabel
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self.thirdActivityIndicator, attribute: .left,
                                                 multiplier: 1, constant: -24)
        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.thirdPendingView, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        return [rightConstraint,
                centerYConstraint]
    }
    
    private func firstImageViewConstraints() -> [NSLayoutConstraint] {
        let imageView: UIImageView = self.firstImageView
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 42)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil, attribute: .width,
                                                 multiplier: 0, constant: 47)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.firstActivityIndicator, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.firstActivityIndicator, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [heightConstraint,
                widthConstraint,
                centerYConstraint,
                centerXConstraint]
    }
    
    private func secondImageViewConstraints() -> [NSLayoutConstraint] {
        let imageView: UIImageView = self.secondImageView
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 42)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil, attribute: .width,
                                                 multiplier: 0, constant: 47)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.secondActivityIndicator, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.secondActivityIndicator, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [heightConstraint,
                widthConstraint,
                centerYConstraint,
                centerXConstraint]
    }
    
    private func thirdImageViewConstraints() -> [NSLayoutConstraint] {
        let imageView: UIImageView = self.thirdImageView
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil, attribute: .height,
                                                  multiplier: 0, constant: 42)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil, attribute: .width,
                                                 multiplier: 0, constant: 47)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.thirdActivityIndicator, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self.thirdActivityIndicator, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        return [heightConstraint,
                widthConstraint,
                centerYConstraint,
                centerXConstraint]
    }
}

extension LoginView {
    @objc private func nationalCodeTextFieldEditingChanged(_ textField: UITextField) {
        self.textFieldsEditingChangedDelegate?.nationalCodeTextFieldEditingChanged(textField)
    }
    
    @objc private func passwordTextFieldEditingChanged(_ textField: UITextField) {
        self.textFieldsEditingChangedDelegate?.passwordTextFieldEditingChanged(textField)
    }
    
    @objc func loginButtonTouchUpInside() {
        self.buttonsTouchUpInsideDelegate?.loginButtonDidTouchUpInside()
    }
    
    @objc func showPasswordButtonTouchUpInside() {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    @objc func forgetPasswordButtonTouchUpInside() {
        print("forget password button pressed")
    }
    
    @objc func fingerPrintButtonTouchUpInside() {
        self.buttonsTouchUpInsideDelegate?.fingerPrintButtonDidTouchUpInside()
    }
}

extension LoginView: LoginViewProtocol {
    func showPendingView() {
        self.pendingView.isHidden = false
    }
    
    func hidePendingView() {
        self.pendingView.isHidden = true
    }
    
    func startAnimatingFirstActivityIndicator() {
        self.firstActivityIndicator.startAnimating()
    }
    
    func stopAnimatingFirstActivityIndicator() {
        self.firstActivityIndicator.stopAnimating()
    }
    
    func startAnimatingSecondActivityIndicator() {
        self.secondActivityIndicator.startAnimating()
    }
    
    func stopAnimatingSecondActivityIndicator() {
        self.secondActivityIndicator.stopAnimating()
    }
    
    func startAnimatingThirdActivityIndicator() {
        self.thirdActivityIndicator.startAnimating()
    }
    
    func stopAnimatingThirdActivityIndicator() {
        self.thirdActivityIndicator.stopAnimating()
    }
    
    func showFirstImageView() {
        self.firstImageView.isHidden = false
    }
    
    func showSecondImageView() {
        self.secondImageView.isHidden = false
    }
    
    func showThirdImageView() {
        self.thirdImageView.isHidden = false
    }
    
    func setFirstLabelText(text: String) {
        self.firstLabel.text = text
    }
    
    func setSecondLabelText(text: String) {
        self.secondLabel.text = text
    }
    
    func setThirdLabelText(text: String) {
        self.thirdLabel.text = text
    }
}
