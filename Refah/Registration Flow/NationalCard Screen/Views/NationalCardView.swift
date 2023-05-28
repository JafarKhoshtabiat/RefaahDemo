//
//  NationalCardView.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import UIKit

class NationalCardView: RegistrationFlowView_NextButton {
    override var prompt: String {
        get {
            return "لطفا تصویر پشت و روی کارت ملی خود را بارگزاری کنید."
        }
        set {}
    }
    var buttonsTouchUpInsideDelegate: UploadPhotoButtonsTouchUpInsideDelegate?
    private let frontImageView = UIImageView()
    private let backImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        let frontButton = UIButton(type: .system)
        frontButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(frontButton)
        let frontButtonTopConstraint = NSLayoutConstraint(item: frontButton, attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: self.promptLabel, attribute: .bottom,
                                                          multiplier: 1, constant: 20)
        let frontButtonRightConstraint = NSLayoutConstraint(item: frontButton, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self.promptLabel, attribute: .right,
                                                            multiplier: 1, constant: 0)
        let frontButtonLeftConstraint = NSLayoutConstraint(item: frontButton, attribute: .left,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .centerX, multiplier: 1, constant: 20)
        let frontButtonHeightConstraint = NSLayoutConstraint(item: frontButton, attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: nil, attribute: .height,
                                                             multiplier: 0, constant: 40)
        self.addConstraints([frontButtonTopConstraint,
                             frontButtonRightConstraint,
                             frontButtonLeftConstraint,
                             frontButtonHeightConstraint])
        frontButton.backgroundColor = UIColor.lightGray
        frontButton.layer.cornerRadius = 5
        frontButton.setTitle("بارگزاری تصویر روی کارت ملی", for: .normal)
        frontButton.titleLabel?.numberOfLines = 0
        frontButton.titleLabel?.textAlignment = .center
        frontButton.tintColor = UIColor.white
        frontButton.addTarget(self, action: #selector(self.frontButtonTouchUpInside), for: .touchUpInside)
        
        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backButton)
        let backButtonTopConstraint = NSLayoutConstraint(item: backButton, attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: frontButton, attribute: .top,
                                                         multiplier: 1, constant: 0)
        let backButtonRightConstraint = NSLayoutConstraint(item: backButton, attribute: .right,
                                                           relatedBy: .equal,
                                                           toItem: self, attribute: .centerX,
                                                           multiplier: 1, constant: -20)
        let backButtonBottomConstraint = NSLayoutConstraint(item: backButton, attribute: .bottom,
                                                            relatedBy: .equal,
                                                            toItem: frontButton, attribute: .bottom,
                                                            multiplier: 1, constant: 0)
        let backButtonLeftConstraint = NSLayoutConstraint(item: backButton, attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: promptLabel, attribute: .left,
                                                          multiplier: 1, constant: 0)
        self.addConstraints([backButtonTopConstraint,
                             backButtonRightConstraint,
                             backButtonBottomConstraint,
                             backButtonLeftConstraint])
        backButton.backgroundColor = UIColor.lightGray
        backButton.layer.cornerRadius = 5
        backButton.setTitle("بارگزاری تصویر پشت کارت ملی", for: .normal)
        backButton.titleLabel?.numberOfLines = 0
        backButton.titleLabel?.textAlignment = .center
        backButton.tintColor = UIColor.white
        backButton.addTarget(self, action: #selector(self.backButtonTouchUpInside), for: .touchUpInside)
        
        let imagesContainerView = UIView()
        imagesContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imagesContainerView)
        let imagesContainerViewTopConstraint = NSLayoutConstraint(item: imagesContainerView, attribute: .top,
                                                                  relatedBy: .equal,
                                                                  toItem: frontButton, attribute: .bottom,
                                                                  multiplier: 1, constant: 20)
        let imagesContainerViewRightConstraint = NSLayoutConstraint(item: imagesContainerView, attribute: .right,
                                                                    relatedBy: .equal,
                                                                    toItem: frontButton, attribute: .right,
                                                                    multiplier: 1, constant: 0)
        let imagesContainerViewBottomConstraint = NSLayoutConstraint(item: imagesContainerView, attribute: .bottom,
                                                                     relatedBy: .equal,
                                                                     toItem: self.nextButton, attribute: .top,
                                                                     multiplier: 1, constant: -20)
        let imagesContainerViewLeftConstraint = NSLayoutConstraint(item: imagesContainerView, attribute: .left,
                                                                   relatedBy: .equal,
                                                                   toItem: backButton, attribute: .left,
                                                                   multiplier: 1, constant: 0)
        self.addConstraints([imagesContainerViewTopConstraint,
                             imagesContainerViewRightConstraint,
                             imagesContainerViewBottomConstraint,
                             imagesContainerViewLeftConstraint])
        
        self.frontImageView.translatesAutoresizingMaskIntoConstraints = false
        imagesContainerView.addSubview(self.frontImageView)
        let frontImageViewTopConstraint = NSLayoutConstraint(item: self.frontImageView, attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: imagesContainerView, attribute: .top,
                                                   multiplier: 1, constant: 0)
        let frontImageViewRightConstraint = NSLayoutConstraint(item: self.frontImageView, attribute: .right, relatedBy: .equal,
                                                     toItem: imagesContainerView, attribute: .right,
                                                     multiplier: 1, constant: 0)
        let frontImageViewBottomConstraint = NSLayoutConstraint(item: self.frontImageView, attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: imagesContainerView, attribute: .centerY,
                                                      multiplier: 1, constant: -10)
        let frontImageViewLeftConstraint = NSLayoutConstraint(item: self.frontImageView, attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: imagesContainerView, attribute: .left,
                                                    multiplier: 1, constant: 0)
        imagesContainerView.addConstraints([frontImageViewTopConstraint,
                                            frontImageViewRightConstraint,
                                            frontImageViewBottomConstraint,
                                            frontImageViewLeftConstraint])
        self.frontImageView.layer.cornerRadius = 20
        self.frontImageView.clipsToBounds = true
        
        self.backImageView.translatesAutoresizingMaskIntoConstraints = false
        imagesContainerView.addSubview(self.backImageView)
        let backImageViewTopConstraint = NSLayoutConstraint(item: self.backImageView, attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: imagesContainerView, attribute: .centerY,
                                                            multiplier: 1, constant: 10)
        let backImageViewRightConstraint = NSLayoutConstraint(item: self.backImageView, attribute: .right,
                                                              relatedBy: .equal,
                                                              toItem: imagesContainerView, attribute: .right,
                                                              multiplier: 1, constant: 0)
        let backImageViewBottomConstraint = NSLayoutConstraint(item: self.backImageView, attribute: .bottom,
                                                               relatedBy: .equal,
                                                               toItem: imagesContainerView, attribute: .bottom,
                                                               multiplier: 1, constant: 0)
        let backImageViewLeftConstraint = NSLayoutConstraint(item: self.backImageView, attribute: .left,
                                                             relatedBy: .equal,
                                                             toItem: imagesContainerView, attribute: .left,
                                                             multiplier: 1, constant: 0)
        imagesContainerView.addConstraints([backImageViewTopConstraint,
                                            backImageViewRightConstraint,
                                            backImageViewBottomConstraint,
                                            backImageViewLeftConstraint])
        self.backImageView.layer.cornerRadius = 20
        self.backImageView.clipsToBounds = true
    }
}

extension NationalCardView: NationalCardViewProtocol {
    @objc func frontButtonTouchUpInside() {
        self.buttonsTouchUpInsideDelegate?.frontButtonDidTouchUpInside()
    }
    
    @objc func backButtonTouchUpInside() {
        self.buttonsTouchUpInsideDelegate?.backButtonDidTouchUpInside()
    }
    
    func setFrontImageViewWith(image: UIImage) {
        self.frontImageView.image = image
    }
    
    func setBackImageViewWith(image: UIImage) {
        self.backImageView.image = image
        
    }
}
