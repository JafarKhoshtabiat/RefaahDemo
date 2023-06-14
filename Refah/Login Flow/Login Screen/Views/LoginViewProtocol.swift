//
//  LoginViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 6/9/23.
//

import UIKit

protocol LoginViewProtocol: ShadowViewProtocol where Self: UIView {
    var textFieldsEditingChangedDelegate: LoginViewTextFieldsEditingChangedDelegate? { get set }
    var textFieldsDelegate: UITextFieldDelegate? { get set }
    var buttonsTouchUpInsideDelegate: LoginViewButtonsTouchUpInsideDelegate? { get set }
    
    func showPendingView()
    func hidePendingView()
    func startAnimatingFirstActivityIndicator()
    func stopAnimatingFirstActivityIndicator()
    func startAnimatingSecondActivityIndicator()
    func stopAnimatingSecondActivityIndicator()
    func startAnimatingThirdActivityIndicator()
    func stopAnimatingThirdActivityIndicator()
    func showFirstImageView()
    func showSecondImageView()
    func showThirdImageView()
    func setFirstLabelText(text: String)
    func setSecondLabelText(text: String)
    func setThirdLabelText(text: String)
}
