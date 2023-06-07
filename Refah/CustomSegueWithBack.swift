//
//  CustomSegueWithBack.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class CustomSegueWithBack: UIStoryboardSegue {
    override func perform() {
        let toViewController = self.destination
        let fromViewController = self.source
        let containerView = fromViewController.view.superview
        containerView?.addSubview(toViewController.view)
        fromViewController.present(toViewController, animated: true)
    }
}
