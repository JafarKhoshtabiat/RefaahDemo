//
//  NationalCardPhotoProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import UIKit

protocol NationalCardPhotoProtocol {
    mutating func setFront(image: UIImage)
    mutating func setBack(image: UIImage)
    func hasFront() -> Bool
    func hasBack() -> Bool
}
