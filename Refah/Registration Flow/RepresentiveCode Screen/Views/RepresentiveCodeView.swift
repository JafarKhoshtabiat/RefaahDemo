//
//  RepresentiveCodeView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

class RepresentiveCodeView: RegistrationFlowViewWithTextFieldAndNextButton {
    override var prompt: String {
        get {
            return "لطفا کد معرف خود را به درستی در کادر زیر وارد نمائید."
        }
        set {}
    }
    override var placeholderText: String {
        get {
            return "کد معرف"
        }
        set {}
    }
    let representiveCodeAvailabilityButton = UIButton(type: .system)
    var representiveCodeAvailabilityDelegate: RepresentiveCodeAvailabilityDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        self.representiveCodeAvailabilityButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.representiveCodeAvailabilityButton)
        let representiveCodeAvailabilityButtonTopConstraint = NSLayoutConstraint(item: self.representiveCodeAvailabilityButton, attribute: .top,
                                                                                 relatedBy: .equal,
                                                                                 toItem: self.textField, attribute: .bottom,
                                                                                 multiplier: 1, constant: 20)
        let representiveCodeAvailabilityButtonRightConstraint = NSLayoutConstraint(item: self.representiveCodeAvailabilityButton, attribute: .right,
                                                                                   relatedBy: .equal,
                                                                                   toItem: self.textField, attribute: .right,
                                                                                   multiplier: 1, constant: 0)
        let representiveCodeAvailabilityButtonHeightConstraint = NSLayoutConstraint(item: self.representiveCodeAvailabilityButton, attribute: .height,
                                                                                    relatedBy: .equal,
                                                                                    toItem: nil, attribute: .height,
                                                                                    multiplier: 0, constant: 22)
        let representiveCodeAvailabilityButtonWidthConstraint = NSLayoutConstraint(item: self.representiveCodeAvailabilityButton, attribute: .width,
                                                                                   relatedBy: .equal,
                                                                                   toItem: nil, attribute: .width,
                                                                                   multiplier: 0, constant: 22)
        self.addConstraints([representiveCodeAvailabilityButtonTopConstraint,
                             representiveCodeAvailabilityButtonRightConstraint,
                             representiveCodeAvailabilityButtonHeightConstraint,
                             representiveCodeAvailabilityButtonWidthConstraint])
        self.representiveCodeAvailabilityButton.setBackgroundImage(UIImage(named: "RedTic_22_22"), for: .normal)
        self.representiveCodeAvailabilityButton.layer.borderWidth = 2
        self.representiveCodeAvailabilityButton.layer.borderColor = UIColor.deepMagenta?.cgColor
        self.representiveCodeAvailabilityButton.layer.cornerRadius = 5
        self.representiveCodeAvailabilityButton.clipsToBounds = true
        self.representiveCodeAvailabilityButton.addTarget(self, action: #selector(self.representiveCodeAvailabilityButtonTouchUpInside), for: .touchUpInside)
        
        let representiveCodeNotAvailableLabel = UILabel()
        representiveCodeNotAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(representiveCodeNotAvailableLabel)
        representiveCodeNotAvailableLabel.text = "کد معرف ندارم."
        representiveCodeNotAvailableLabel.textColor = UIColor.extinctVolcano
        representiveCodeNotAvailableLabel.font = UIFont.systemFont(ofSize: 12)
        representiveCodeNotAvailableLabel.textAlignment = .right
        representiveCodeNotAvailableLabel.numberOfLines = 1
        let representiveCodeNotAvailableLabelRightConstraint =  NSLayoutConstraint(item: representiveCodeNotAvailableLabel, attribute: .right,
                                                                                   relatedBy: .equal,
                                                                                   toItem: representiveCodeAvailabilityButton, attribute: .left,
                                                                                   multiplier: 1, constant: -10)
        let representiveCodeNotAvailableLabelCenterYConstraint = NSLayoutConstraint(item: representiveCodeNotAvailableLabel, attribute: .centerY,
                                                                                    relatedBy: .equal,
                                                                                    toItem: representiveCodeAvailabilityButton, attribute: .centerY,
                                                                                    multiplier: 1, constant: 0)
        self.addConstraints([representiveCodeNotAvailableLabelRightConstraint,
                             representiveCodeNotAvailableLabelCenterYConstraint])
    }
}

extension RepresentiveCodeView: RepresentiveCodeViewProtocol {
    @objc func representiveCodeAvailabilityButtonTouchUpInside() {
        self.representiveCodeAvailabilityDelegate?.representiveCodeAvailabilityDidToggle()
    }
    
    func representiveCodeAvailabilityUpdated(isAvailable: Bool) {
        if isAvailable {
            self.representiveCodeAvailabilityButton.setBackgroundImage(nil, for: .normal)
            print("remove pic")
        } else {
            self.representiveCodeAvailabilityButton.setBackgroundImage(UIImage(named: "RedTic_22_22"), for: .normal)
            print("add pic")
        }
    }
}
