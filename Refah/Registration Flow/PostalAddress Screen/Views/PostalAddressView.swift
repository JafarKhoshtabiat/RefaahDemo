//
//  PostalAddressView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/29/23.
//

import UIKit

class PostalAddressView: RegistrationFlowView_TextField_ValidatoinLabel_NextButton {
    override var prompt: String {
        get {
            return "لطفا استان و شهر و کدپستی محل سکونت خود را وارد نمایید."
        }
        set {}
    }
    override var placeholderText: String {
        get {
            return "کدپستی"
        }
        set {}
    }
    override var isValidText: String {
        get {
            return "کدپستی معتبر است."
        }
        set {}
    }
    override var isNotValidText: String {
        get {
            return "کدپستی معتبر نیست."
        }
        set {}
    }
    private let stateNameLabel = UILabel()
    private let cityNameLabel = UILabel()
    var postalAddressButtonsTouchUpInsideDelegate: PostalAddressButtonsTouchUpInsideDelegate?
    private let shadowView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    private let pickerView = UIPickerView()
    private let confirmButton = UIButton(type: .system)
    var pickerViewDelegateAndDataSource: PostalAddressPickerViewDelegateAndDataSourceProtocol? {
        didSet {
            self.pickerView.delegate = self.pickerViewDelegateAndDataSource
            self.pickerView.dataSource = self.pickerViewDelegateAndDataSource
        }
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
        self.promptLabel.numberOfLines = 0
        self.textField.keyboardType = .asciiCapableNumberPad
        
        let statesButton = UIButton(type: .system)
        statesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statesButton)
        let statesButtonTopConstraint = NSLayoutConstraint(item: statesButton, attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: self.promptLabel, attribute: .bottom,
                                                          multiplier: 1, constant: 20)
        let statesButtonRightConstraint = NSLayoutConstraint(item: statesButton, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self.promptLabel, attribute: .right,
                                                            multiplier: 1, constant: 0)
        let statesButtonLeftConstraint = NSLayoutConstraint(item: statesButton, attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .centerX, multiplier: 1, constant: 20)
        let statesButtonHeightConstraint = NSLayoutConstraint(item: statesButton, attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: nil, attribute: .height,
                                                             multiplier: 0, constant: 40)
        self.addConstraints([statesButtonTopConstraint,
                             statesButtonRightConstraint,
                             statesButtonLeftConstraint,
                             statesButtonHeightConstraint])
        statesButton.backgroundColor = UIColor.lightGray
        statesButton.layer.cornerRadius = 5
        statesButton.setTitle("انتخاب استان", for: .normal)
        statesButton.titleLabel?.numberOfLines = 0
        statesButton.titleLabel?.textAlignment = .center
        statesButton.tintColor = UIColor.white
        statesButton.addTarget(self, action: #selector(self.statesButtonTouchUpInside), for: .touchUpInside)
        
        let citiesButton = UIButton(type: .system)
        citiesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(citiesButton)
        let citiesButtonTopConstraint = NSLayoutConstraint(item: citiesButton, attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: statesButton, attribute: .bottom,
                                                          multiplier: 1, constant: 20)
        let citiesButtonRightConstraint = NSLayoutConstraint(item: citiesButton, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self.promptLabel, attribute: .right,
                                                            multiplier: 1, constant: 0)
        let citiesButtonLeftConstraint = NSLayoutConstraint(item: citiesButton, attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: statesButton, attribute: .left,
                                                            multiplier: 1, constant: 0)
        let citiesButtonHeightConstraint = NSLayoutConstraint(item: citiesButton, attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: statesButton, attribute: .height,
                                                             multiplier: 1, constant: 0)
        self.addConstraints([citiesButtonTopConstraint,
                             citiesButtonRightConstraint,
                             citiesButtonLeftConstraint,
                             citiesButtonHeightConstraint])
        citiesButton.backgroundColor = UIColor.lightGray
        citiesButton.layer.cornerRadius = 5
        citiesButton.setTitle("انتخاب شهر", for: .normal)
        citiesButton.titleLabel?.numberOfLines = 0
        citiesButton.titleLabel?.textAlignment = .center
        citiesButton.tintColor = UIColor.white
        citiesButton.addTarget(self, action: #selector(self.citiesButtonTouchUpInside), for: .touchUpInside)
        
        let textFieldNewTopConstraint = NSLayoutConstraint(item: self.textField, attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: citiesButton, attribute: .bottom,
                                                           multiplier: 1, constant: 20)
        self.updateTextFieldTopConstraint(newConstraint: textFieldNewTopConstraint)
        
        self.stateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stateNameLabel)
        let stateNameLabelTopConstraint = NSLayoutConstraint(item: self.stateNameLabel, attribute: .top,
                                                             relatedBy: .equal,
                                                             toItem: statesButton, attribute: .top,
                                                             multiplier: 1, constant: 0)
        let stateNameLabelRightConstraint = NSLayoutConstraint(item: self.stateNameLabel, attribute: .right,
                                                               relatedBy: .equal,
                                                               toItem: self, attribute: .centerX,
                                                               multiplier: 1, constant: -20)
        let stateNameLabelBottomConstraint = NSLayoutConstraint(item: self.stateNameLabel, attribute: .bottom,
                                                                relatedBy: .equal,
                                                                toItem: statesButton, attribute: .bottom,
                                                                multiplier: 1, constant: 0)
        let stateNameLabelLeftConstraint = NSLayoutConstraint(item: self.stateNameLabel, attribute: .left,
                                                              relatedBy: .equal,
                                                              toItem: self.promptLabel, attribute: .left,
                                                              multiplier: 1, constant: 0)
        self.addConstraints([stateNameLabelTopConstraint,
                             stateNameLabelRightConstraint,
                             stateNameLabelBottomConstraint,
                             stateNameLabelLeftConstraint])
        self.stateNameLabel.layer.cornerRadius = 10
        self.stateNameLabel.layer.borderWidth = 1
        self.stateNameLabel.layer.borderColor = UIColor.shadowMountain.cgColor
        self.stateNameLabel.textAlignment = .center
        self.stateNameLabel.font = UIFont.systemFont(ofSize: 17)
        self.stateNameLabel.text = "نام استان"
        
        self.cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.cityNameLabel)
        let cityNameLabelTopConstraint = NSLayoutConstraint(item: self.cityNameLabel, attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: citiesButton, attribute: .top,
                                                            multiplier: 1, constant: 0)
        let cityNameLabelRightConstraint = NSLayoutConstraint(item: self.cityNameLabel, attribute: .right,
                                                              relatedBy: .equal,
                                                              toItem: self.stateNameLabel, attribute: .right,
                                                              multiplier: 1, constant: 0)
        let cityNameLabelBottomConstraint = NSLayoutConstraint(item: self.cityNameLabel, attribute: .bottom,
                                                               relatedBy: .equal,
                                                               toItem: citiesButton, attribute: .bottom,
                                                               multiplier: 1, constant: 0)
        let cityNameLabelLeftConstraint = NSLayoutConstraint(item: self.cityNameLabel, attribute: .left,
                                                             relatedBy: .equal,
                                                             toItem: self.stateNameLabel, attribute: .left,
                                                             multiplier: 1, constant: 0)
        self.addConstraints([cityNameLabelTopConstraint,
                             cityNameLabelRightConstraint,
                             cityNameLabelBottomConstraint,
                             cityNameLabelLeftConstraint])
        self.cityNameLabel.layer.cornerRadius = 10
        self.cityNameLabel.layer.borderWidth = 1
        self.cityNameLabel.layer.borderColor = UIColor.shadowMountain.cgColor
        self.cityNameLabel.textAlignment = .center
        self.cityNameLabel.font = UIFont.systemFont(ofSize: 17)
        self.cityNameLabel.text = "نام شهر"
        
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.shadowView)
        let shadowViewTopConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: self, attribute: .top,
                                                         multiplier: 1, constant: 0)
        let shadowViewRightConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .right,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .right,
                                                           multiplier: 1, constant: 0)
        let shadowViewLeftConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: self, attribute: .bottom,
                                                          multiplier: 1, constant: 0)
        let shadowViewBottomConstraint = NSLayoutConstraint(item: self.shadowView, attribute: .left,
                                                            relatedBy: .equal,
                                                            toItem: self, attribute: .left,
                                                            multiplier: 1, constant: 0)
        self.addConstraints([shadowViewTopConstraint,
                             shadowViewRightConstraint,
                             shadowViewLeftConstraint,
                             shadowViewBottomConstraint])
        self.shadowView.backgroundColor = UIColor.fuelTown.withAlphaComponent(0.6)
        self.shadowView.isHidden = true
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        let activityIndicatorCenterYConstraint = NSLayoutConstraint(item: self.activityIndicator, attribute: .centerY,
                                                                    relatedBy: .equal,
                                                                    toItem: self, attribute: .centerY,
                                                                    multiplier: 1, constant: 0)
        let activityIndicatorCenterXConstraint = NSLayoutConstraint(item: self.activityIndicator, attribute: .centerX,
                                                                    relatedBy: .equal,
                                                                    toItem: self, attribute: .centerX,
                                                                    multiplier: 1, constant: 0)
        self.addConstraints([activityIndicatorCenterYConstraint,
                             activityIndicatorCenterXConstraint])
        activityIndicator.hidesWhenStopped = true
        
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerView)
        let pickerViewCenterYConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .centerY,
                                                             relatedBy: .equal,
                                                             toItem: self, attribute: .centerY,
                                                             multiplier: 1, constant: 0)
        let pickerViewCenterXConstraint = NSLayoutConstraint(item: self.pickerView, attribute: .centerX,
                                                             relatedBy: .equal,
                                                             toItem: self, attribute: .centerX,
                                                             multiplier: 1, constant: 0)
        self.addConstraints([pickerViewCenterYConstraint,
                             pickerViewCenterXConstraint])
        self.pickerView.backgroundColor = UIColor.herbal
        self.pickerView.isHidden = true
        self.pickerView.layer.cornerRadius = 30
        
        self.confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.confirmButton)
        let confirmButtonBottomConstraint = NSLayoutConstraint(item: self.confirmButton, attribute: .bottom,
                                                               relatedBy: .equal,
                                                               toItem: self.pickerView, attribute: .top,
                                                               multiplier: 1, constant: -20)
        let confirmButtonHeightConstraint = NSLayoutConstraint(item: self.confirmButton, attribute: .height,
                                                               relatedBy: .equal,
                                                               toItem: statesButton, attribute: .height,
                                                               multiplier: 1, constant: 0)
        let confirmButtonWidthConstraint = NSLayoutConstraint(item: self.confirmButton, attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: statesButton, attribute: .width,
                                                              multiplier: 1, constant: 0)
        let confirmButtonCenterXConstraint = NSLayoutConstraint(item: confirmButton, attribute: .centerX,
                                                                relatedBy: .equal,
                                                                toItem: self, attribute: .centerX,
                                                                multiplier: 1, constant: 0)
        self.addConstraints([confirmButtonBottomConstraint,
                             confirmButtonHeightConstraint,
                             confirmButtonWidthConstraint,
                             confirmButtonCenterXConstraint])
        self.confirmButton.backgroundColor = UIColor.lightGray
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.setTitle("تأیید", for: .normal)
        self.confirmButton.titleLabel?.numberOfLines = 0
        self.confirmButton.titleLabel?.textAlignment = .center
        self.confirmButton.tintColor = UIColor.white
        self.confirmButton.addTarget(self, action: #selector(self.confirmButtonTouchUpInside), for: .touchUpInside)
        self.confirmButton.isHidden = true
    }
}

extension PostalAddressView {
    @objc private func statesButtonTouchUpInside() {
        self.postalAddressButtonsTouchUpInsideDelegate?.statesButtonDidTouchUpInside()
    }
    
    @objc private func citiesButtonTouchUpInside() {
        self.postalAddressButtonsTouchUpInsideDelegate?.citiesButtonDidTouchUpInside()
    }
    
    @objc private func confirmButtonTouchUpInside() {
        self.postalAddressButtonsTouchUpInsideDelegate?.confirmButtonDidTouchUpInside()
    }
}

extension PostalAddressView: PostalAddressViewProtocol {
    func resetCityNameLabel() {
        self.cityNameLabel.text = "نام شهر"
    }
    
    func showShadowView() {
        self.shadowView.isHidden = false
    }
    
    func hideShadowView() {
        self.shadowView.isHidden = true
    }
    
    func startAnimatingActivityIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimatingActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func showPickerView() {
        self.pickerView.isHidden = false
    }
    
    func hidePickerView() {
        self.pickerView.isHidden = true
    }
    
    func reloadPickerView() {
        self.pickerView.reloadAllComponents()
    }
    
    func showConfirmButton() {
        self.confirmButton.isHidden = false
    }
    
    func hideConfirmButton() {
        self.confirmButton.isHidden = true
    }
    
    func getSelectedRowInPickerView() -> Int {
        let row = self.pickerView.selectedRow(inComponent: 0)
        return row
    }
    
    func selectPickerViewWith(index: Int) {
        self.pickerView.selectRow(index, inComponent: 0, animated: false)
    }
    
    func setStateNameLabelTo(stateName: String) {
        self.stateNameLabel.text = stateName
    }
    
    func setCityNameLabelTo(cityName: String) {
        self.cityNameLabel.text = cityName
    }
}
