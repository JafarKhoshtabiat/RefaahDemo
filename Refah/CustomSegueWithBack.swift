//
//  CustomSegueWithBack.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class CustomSegueWithBack: UIStoryboardSegue {
    override func perform() {
        let source = self.source
        let destination = self.destination
        source.present(destination, animated: true)
    }
}
