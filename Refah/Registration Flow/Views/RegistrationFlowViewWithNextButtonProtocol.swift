//
//  RegistrationFlowViewWithNextButtonProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

protocol RegistrationFlowViewWithNextButtonProtocol where Self: UIView {
    var flowNextDelegate: RegistrationFlowNextDelegate? { get set }
    var createAccountLabel: UILabel { get }
    var prompt: String { get set }
    var promptLabel: UILabel { get }
    var nextButton: UIButton { get }
    
    func nextButtonTouchUpInside()
}
