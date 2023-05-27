//
//  RegistrationFlowView_NextButton_Protocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import UIKit

protocol RegistrationFlowView_NextButton_Protocol where Self: UIView {
    var flowNextDelegate: RegistrationFlowNextDelegate? { get set }
    var createAccountLabel: UILabel { get }
    var prompt: String { get set }
    var promptLabel: UILabel { get }
    var nextButton: UIButton { get }
    
    func nextButtonTouchUpInside()
}
