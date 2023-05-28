//
//  NewRegistrationPhoneNumberViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    private var phoneNumberView: RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol = PhoneNumberView()
    var phoneNumberIsValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumberView.flowNextDelegate = self
        self.phoneNumberView.textFieldDelegate = self
        self.phoneNumberView.textFieldEditingChangedDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.phoneNumberView.makeTextFieldFirstResponder()
    }
    
    override func loadView() {
        self.view = self.phoneNumberView
    }
}

extension PhoneNumberViewController: RegistrationFlowNextDelegate {
    func next() {
        if self.phoneNumberIsValid {
            self.performSegue(withIdentifier: "PhoneNumber_to_OTC", sender: nil)
        } else {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor.flameHawkfish!, message: "شماره موبایل معتبر نیست.")
        }
    }
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

extension PhoneNumberViewController: TextFieldEditingChangedDelegate {
    func editingChanged(_ textField: UITextField) {
        guard let currentText = textField.text else {
            self.phoneNumberView.hideValidationLabel()
            return
        }
        
        if currentText.count == "09123456789".count && currentText.starts(with: "09") {
            self.phoneNumberIsValid = true
            self.phoneNumberView.showValidationLabel(isValid: true)
            textField.resignFirstResponder()
        } else if (!currentText.starts(with: "0") && currentText.count >= 1) ||
                  (currentText.starts(with: "0") && !currentText.starts(with: "09") && currentText.count >= 2) ||
                    currentText.count > "09123456789".count {
            self.phoneNumberIsValid = false
            self.phoneNumberView.showValidationLabel(isValid: false)
        } else {
            self.phoneNumberIsValid = false
            self.phoneNumberView.hideValidationLabel()
        }
    }
}
