//
//  NationalCardViewProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import UIKit

protocol NationalCardViewProtocol: RegistrationFlowView_NextButton_Protocol {
    var buttonsTouchUpInsideDelegate: UploadPhotoButtonsTouchUpInsideDelegate? { get set }
    
    func frontButtonTouchUpInside()
    func backButtonTouchUpInside()
    func setFrontImageViewWith(image: UIImage)
    func setBackImageViewWith(image: UIImage)
}
