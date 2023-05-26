//
//  RegistrationStatusViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/26/23.
//

import UIKit

class RegistrationStatusViewController: UIViewController {
    private var registrationStatusView: RegistrationStatusViewProtocol = RegistrationStatusView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registrationStatusView.registrationStatusDelegate = self
    }
    
    override func loadView() {
        self.view = self.registrationStatusView
    }
}

extension RegistrationStatusViewController: RegistrationStatusDelegate {
    func newRegister() {
        self.performSegue(withIdentifier: "RegistrationStatus_to_RepresentiveCode", sender: nil)
    }
    
    func login() {
        self.performSegue(withIdentifier: "RegistrationStatus_to_Login", sender: nil)
    }
}
