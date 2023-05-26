//
//  ViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/26/23.
//

import UIKit

class LaunchViewController: UIViewController {
    private var launchView: LaunchViewWithProgressViewProtocol = LaunchView()
    
    private func mockProgress() {
        for i in 1...4{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 1.0) {
                self.launchView.setProgressOfProgressView(0.25 * Float(i), animated: true)
                
                if i == 4 {
                    self.performSegue(withIdentifier: "Launch_To_RegistrationStatus", sender: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mockProgress()
    }
    
    override func loadView() {
        self.view = self.launchView
    }
}
