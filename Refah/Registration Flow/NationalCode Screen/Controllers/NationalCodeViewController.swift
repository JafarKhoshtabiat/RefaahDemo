//
//  NationalCodeViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/1/23.
//

import UIKit

class NationalCodeViewController: UIViewController {
    var nationalCodeView: RegistrationFlowView_FirstResponderTextField_ValidatoinLabel_NextButton_Protocol = NationalCodeView()
    
    var nationalCodeIsValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nationalCodeView.flowNextDelegate = self
        self.nationalCodeView.textFieldDelegate = self
        self.nationalCodeView.textFieldEditingChangedDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.nationalCodeView.makeTextFieldFirstResponder()
    }
    
    override func loadView() {
        self.view = self.nationalCodeView
    }
}

extension NationalCodeViewController: RegistrationFlowNextDelegate {
    func next() {
        if self.nationalCodeIsValid {
            self.performSegue(withIdentifier: "NationalCode_to_NationalCard", sender: nil)
        } else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "کدملی واردشده معتبر نیست.")
        }
    }
}

extension NationalCodeViewController: UITextFieldDelegate {
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

extension NationalCodeViewController: TextFieldEditingChangedDelegate {
    func editingChanged(_ textField: UITextField) {
        guard let currentText = textField.text else { self.nationalCodeView.hideValidationLabel(); return }
        
        if currentText.count == "1234567890".count {
            self.nationalCodeIsValid = true
            self.nationalCodeView.showValidationLabel(isValid: true)
            textField.resignFirstResponder()
        } else if currentText.count > "1234567890".count {
            self.nationalCodeIsValid = false
            self.nationalCodeView.showValidationLabel(isValid: false)
        } else {
            self.nationalCodeIsValid = false
            self.nationalCodeView.hideValidationLabel()
        }
    }
}
