//
//  RegistrationStatusViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

protocol RegistrationStatusViewProtocol where Self: UIView {
    var registrationStatusDelegate: RegistrationStatusDelegate? { get set }
    
    func newRegisterButtonTouchUpInside()
    func loginButtonTouchUpInside()
}
