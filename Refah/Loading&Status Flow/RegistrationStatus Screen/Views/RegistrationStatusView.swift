//
//  RegistrationStatusView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

class RegistrationStatusView: UIView {
    var registrationStatusDelegate: RegistrationStatusDelegate?
    
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
        
        let refahLogoImageView = UIImageView()
        refahLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(refahLogoImageView)
        refahLogoImageView.frame.size.height = 200
        refahLogoImageView.frame.size.width = 250
        let refahLogoNameImageViewCenterYConstraint = NSLayoutConstraint(item: refahLogoImageView, attribute: .centerY,
                                                                         relatedBy: .equal,
                                                                         toItem: self, attribute: .centerY,
                                                                         multiplier: 1, constant: 0)
        let refahLogoImageViewCenterXConstraint = NSLayoutConstraint(item: refahLogoImageView, attribute: .centerX,
                                                                 relatedBy: .equal,
                                                                 toItem: self, attribute: .centerX,
                                                                 multiplier: 1, constant: 0)
        self.addConstraints([refahLogoNameImageViewCenterYConstraint, refahLogoImageViewCenterXConstraint])
        if let refahLogoNameImage = UIImage(named: "Refah_Logo_Name") {
            refahLogoImageView.image = refahLogoNameImage
        }
        
        let newRegisterButton = UIButton(type: .system)
        newRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newRegisterButton)
        let newRegisterButtonRightConstarint = NSLayoutConstraint(item: newRegisterButton, attribute: .right,
                                                                  relatedBy: .equal,
                                                                  toItem: self, attribute: .right,
                                                                  multiplier: 1, constant: -20)
        let newRegisterButtonBottomConstraint = NSLayoutConstraint(item: newRegisterButton, attribute: .bottom,
                                                                   relatedBy: .equal,
                                                                   toItem: self, attribute: .bottom,
                                                                   multiplier: 1, constant: -60)
        let newRegisterButtonLeftConstraint = NSLayoutConstraint(item: newRegisterButton, attribute: .left,
                                                                 relatedBy: .equal,
                                                                 toItem: self, attribute: .centerX,
                                                                 multiplier: 1, constant: 20)
        let newRegisterButtonHeightConstraint = NSLayoutConstraint(item: newRegisterButton, attribute: .height,
                                                                   relatedBy: .equal,
                                                                   toItem: self, attribute: .height, multiplier: 0, constant: 40)
        self.addConstraints([newRegisterButtonRightConstarint, newRegisterButtonBottomConstraint, newRegisterButtonLeftConstraint, newRegisterButtonHeightConstraint])
        newRegisterButton.backgroundColor = UIColor.carnival
        newRegisterButton.layer.cornerRadius = 20
        newRegisterButton.setTitle("ثبت‌نام جدید", for: .normal)
        newRegisterButton.setTitleColor(UIColor.white, for: .normal)
        newRegisterButton.addTarget(self, action: #selector(self.newRegisterButtonTouchUpInside), for: .touchUpInside)
        
        let loginButton = UIButton(type: .system)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
        let loginButtonTopconstraint = NSLayoutConstraint(item: loginButton, attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: newRegisterButton, attribute: .top,
                                                          multiplier: 1, constant: 0)
        let loginButtonRightConstraint = NSLayoutConstraint(item: loginButton, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self, attribute: .centerX,
                                                            multiplier: 1, constant: -20)
        let loginButtonHeightConstraint = NSLayoutConstraint(item: loginButton, attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: newRegisterButton, attribute: .height,
                                                             multiplier: 1, constant: 0)
        let loginButtonWidthConstraint = NSLayoutConstraint(item: loginButton, attribute: .width,
                                                            relatedBy: .equal,
                                                            toItem: newRegisterButton, attribute: .width,
                                                            multiplier: 1, constant: 0)
        self.addConstraints([loginButtonTopconstraint, loginButtonRightConstraint, loginButtonHeightConstraint, loginButtonWidthConstraint])
        loginButton.layer.borderColor = UIColor.deepSeaDream?.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 20
        loginButton.setTitle("ثبت‌نام کرده‌ام", for: .normal)
        loginButton.setTitleColor(UIColor.deepSeaDream, for: .normal)
        loginButton.addTarget(self, action: #selector(self.loginButtonTouchUpInside), for: .touchUpInside)
    }
}

extension RegistrationStatusView: RegistrationStatusViewProtocol {
    @objc func newRegisterButtonTouchUpInside() {
        self.registrationStatusDelegate?.newRegister()
    }

    @objc func loginButtonTouchUpInside() {
        self.registrationStatusDelegate?.login()
    }
}
