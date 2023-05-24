//
//  NewRegisterViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/27/23.
//

import UIKit

class RepresentiveCodeViewController: UIViewController {

    @IBOutlet weak var representiveCodeTextField: UITextField!
    @IBOutlet weak var representiveCodeAvailabilityButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var representiveCodeisAvailable: Bool = false
    
    @IBAction func representiveCodeAvailabilityButtonToggled(_ sender: UIButton) {
        self.representiveCodeisAvailable.toggle()
        
        if self.representiveCodeisAvailable {
            self.representiveCodeAvailabilityButton.setImage(nil, for: .normal)
            self.representiveCodeAvailabilityButton.imageView?.isHidden = true
        } else {
            self.representiveCodeAvailabilityButton.setImage(UIImage(named: "RedTic_22_22")!, for: .normal)
            self.representiveCodeAvailabilityButton.imageView?.isHidden = false
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.representiveCodeTextField.layer.cornerRadius = 20
        self.representiveCodeTextField.layer.borderWidth = 2
        self.representiveCodeTextField.layer.borderColor = CGColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.representiveCodeTextField.clipsToBounds = true
        
        self.representiveCodeAvailabilityButton.layer.borderColor = CGColor(red: 164/255, green: 0, blue: 93/255, alpha: 1)
        self.representiveCodeAvailabilityButton.layer.borderWidth = 2
        self.representiveCodeAvailabilityButton.layer.cornerRadius = 5
        self.representiveCodeAvailabilityButton.setImage(UIImage(named: "RedTic_22_22")!, for: .normal)
        self.representiveCodeAvailabilityButton.clipsToBounds = true
        
        self.nextButton.layer.cornerRadius = 20
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
