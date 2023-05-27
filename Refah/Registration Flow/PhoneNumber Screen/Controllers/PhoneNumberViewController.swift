//
//  NewRegistrationPhoneNumberViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit

class PhoneNumberViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneNumberValidLabel: UILabel!
    
    var phoneNumberIsValid = false
    
    @IBAction func phoneNumberTextFieldEditingChanged(_ sender: UITextField) {
        guard let currentText = sender.text else { self.phoneNumberValidLabel.isHidden = true; return }
        
        if currentText.count == "09123456789".count && currentText.starts(with: "09") {
            self.phoneNumberIsValid = true
            
            self.phoneNumberValidLabel.text = "شماره موبایل معتبر است."
            self.phoneNumberValidLabel.textColor = UIColor(named: "GreenJungle")
            self.phoneNumberValidLabel.isHidden = false
            self.phoneNumberTextField.resignFirstResponder()
        } else if (!currentText.starts(with: "0") && currentText.count >= 1) ||
                  (currentText.starts(with: "0") && !currentText.starts(with: "09") && currentText.count >= 2) ||
                    currentText.count > "09123456789".count {
            self.phoneNumberIsValid = false
            
            self.phoneNumberValidLabel.text = "شماره موبایل معتبر نیست."
            self.phoneNumberValidLabel.textColor = UIColor(named: "Flame Hawkfish")
            self.phoneNumberValidLabel.isHidden = false
        } else {
            self.phoneNumberIsValid = false
            
            self.phoneNumberValidLabel.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.phoneNumberIsValid {
            self.performSegue(withIdentifier: "phoneNumbertoOTPSegue", sender: nil)
        } else {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "شماره موبایل معتبر نیست.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumberTextField.delegate = self
        
        self.phoneNumberTextField.layer.cornerRadius = 20
        self.phoneNumberTextField.layer.borderWidth = 2
        self.phoneNumberTextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        self.phoneNumberTextField.clipsToBounds = true
        
        self.nextButton.layer.cornerRadius = 20
        
        self.phoneNumberValidLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.phoneNumberTextField.becomeFirstResponder()
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

extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " else { return false }
        guard string != "\n" else { return false }
        
        if string == "" {
            return true
        }
        
        let digits = "0123456789"
        if digits.contains(string) {
            return true
        }
        
        return false
    }
}
