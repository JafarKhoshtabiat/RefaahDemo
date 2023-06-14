//
//  ShadowViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/9/23.
//

import UIKit

protocol ShadowViewProtocol where Self: UIView {
    var shadowView: UIView! { get set }
    
    func createShadowView()
    func showShadowView()
    func hideShadowView()
}

extension ShadowViewProtocol {
    func createShadowView() {
        self.shadowView = UIView()
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowView.backgroundColor = UIColor.fuelTown.withAlphaComponent(0.6)
        self.addSubview(self.shadowView)
        let tempView: UIView = self.shadowView
        let topConstraint = NSLayoutConstraint(item: tempView, attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self, attribute: .top,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: tempView, attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: self, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: tempView, attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self, attribute: .bottom,
                                                  multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: tempView, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1, constant: 0)
        self.addConstraints([topConstraint,
                             rightConstraint,
                             bottomConstraint,
                             leftConstraint])
        self.shadowView.isHidden = true
    }
    
    func showShadowView() {
        self.shadowView.isHidden = false
    }
    
    func hideShadowView() {
        self.shadowView.isHidden = true
    }
}
