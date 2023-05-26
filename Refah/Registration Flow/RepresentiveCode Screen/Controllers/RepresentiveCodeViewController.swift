//
//  NewRegisterViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/27/23.
//

import UIKit

class RepresentiveCodeViewController: UIViewController {
    private var representiveCodeView: RepresentiveCodeViewProtocol = RepresentiveCodeView()
    var representiveCodeisAvailable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.representiveCodeView.flowNextDelegate = self
        self.representiveCodeView.textFieldDelegate = self
        self.representiveCodeView.textFieldEditingChangedDelegate = self
        self.representiveCodeView.representiveCodeAvailabilityDelegate = self
    }
    
    override func loadView() {
        self.view = self.representiveCodeView
    }
}

extension RepresentiveCodeViewController: RegistrationFlowNextDelegate {
    func next() {
        self.performSegue(withIdentifier: "RepresentiveCode_to_PhoneNumber", sender: nil)
    }
}

extension RepresentiveCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " else { return false }
        guard string != "\n" else {
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}

extension RepresentiveCodeViewController: TextFieldEditingChangedDelegate {
    func editingChanged(_ textField: UITextField) {
        // TODO: implement
        print(textField.text)
    }
}

extension RepresentiveCodeViewController: RepresentiveCodeAvailabilityDelegate {
    func representiveCodeAvailabilityDidToggle() {
        self.representiveCodeisAvailable.toggle()
        self.representiveCodeView.representiveCodeAvailabilityUpdated(isAvailable: self.representiveCodeisAvailable)
    }
}

protocol RepresentiveCodeAvailabilityDelegate {
    func representiveCodeAvailabilityDidToggle()
}
