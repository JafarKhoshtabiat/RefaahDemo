//
//  extension+UIViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

@nonobjc extension UIViewController {
    func presentUIAlertController(title: String, titleColor: UIColor, message: String) {
        let attributedTitle = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : titleColor
        ])

        let alert = UIAlertController(title: "", message: message,  preferredStyle: .alert)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        let okAction = UIAlertAction(title: "متوجه شدم", style: .default) { (_) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentUIAlertController(title: String, titleColor: UIColor, message: String, style: UIAlertController.Style, okActionTitle: String, okActionCompletion: @escaping (UIAlertAction) -> ()) {
        let attributedTitle = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), //your font here
            NSAttributedString.Key.foregroundColor : titleColor
        ])

        let alert = UIAlertController(title: "", message: message,  preferredStyle: style)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: okActionCompletion)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
