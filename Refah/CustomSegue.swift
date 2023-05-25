//
//  CustomSegue.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.willRemoveSubview(fromViewController.view)
        containerView?.addSubview(toViewController.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            // TODO -> solve warning here [Window] Manually adding the rootViewController's view to the view hierarchy is no longer supported. Please allow UIWindow to add the rootViewController's view to the view hierarchy itself.
            containerView?.window?.rootViewController = toViewController
        })
    }
}
