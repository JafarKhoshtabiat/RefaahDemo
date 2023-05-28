//
//  NationalCardPhoto.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import UIKit

struct NationalCardPhoto: NationalCardPhotoProtocol {
    private var front: UIImage?
    private var back: UIImage?
    
    mutating func setFront(image: UIImage) {
        self.front = image
    }
    
    mutating func setBack(image: UIImage) {
        self.back = image
    }
    
    func hasFront() -> Bool {
        if let _ = self.front {
            return true
        }
        
        return false
    }
    
    func hasBack() -> Bool {
        if let _ = self.back {
            return true
        }
        
        return false
    }
}
