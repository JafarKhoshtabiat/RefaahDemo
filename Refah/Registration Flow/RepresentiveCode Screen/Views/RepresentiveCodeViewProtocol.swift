//
//  RepresentiveCodeViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/27/23.
//

import UIKit

protocol RepresentiveCodeViewProtocol: RegistrationFlowViewWithTextFieldAndNextButtonProtocol {
    var representiveCodeAvailabilityButton: UIButton { get }
    var representiveCodeAvailabilityDelegate: RepresentiveCodeAvailabilityDelegate? { get set }
    
    func representiveCodeAvailabilityButtonTouchUpInside()
    func representiveCodeAvailabilityUpdated(isAvailable: Bool)
}

