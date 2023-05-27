//
//  PhoneNumberOTPViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class OneTimeCodeViewController: UIViewController {
    var oneTimeCodeView: OneTimeCodeViewProtocol = OneTimeCodeView()
    
    var otc: OTCProtocol = OTC(size: 5)
    
    var stayInSameOTCTextField = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.oneTimeCodeView.flowNextDelegate = self
        self.oneTimeCodeView.otcTextFieldDelegate = self
        self.oneTimeCodeView.otcTextFieldEditingChangedDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc0.rawValue)
    }
    
    override func loadView() {
        self.view = self.oneTimeCodeView
    }
}

extension OneTimeCodeViewController: RegistrationFlowNextDelegate {
    func next() {
        if self.otc.isAllOTCsEntered() {
            self.performSegue(withIdentifier: "OneTimeCode_to_NationalCode", sender: nil)
        } else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish!, message: "کد معتبر نیست.")
        }
    }
}

extension OneTimeCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("delegate")
        guard string != " " || string != "\n" else {
            switch textField.tag {
            case OTCTextFieldTag.otc0.rawValue:
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc1.rawValue)
            case OTCTextFieldTag.otc1.rawValue:
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc2.rawValue)
            case OTCTextFieldTag.otc2.rawValue:
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc3.rawValue)
            case OTCTextFieldTag.otc3.rawValue:
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
            case OTCTextFieldTag.otc4.rawValue:
                textField.resignFirstResponder()
            default:
                break
            }
            
            return false
        }
        
        if string == "" {    // when user deletes a digit
            self.stayInSameOTCTextField = true
            return true
        }
        
        let digits = "0123456789"
        if digits.contains(string) {
            switch textField.tag {
            case OTCTextFieldTag.otc0.rawValue:
                if self.otc.isOTCEnteredIn(index: 0) {
                    self.otc.setOTCIn(index: 0, otc: "")
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc0.rawValue, text: "")
                }
            case OTCTextFieldTag.otc1.rawValue:
                if self.otc.isOTCEnteredIn(index: 1) {
                    self.otc.setOTCIn(index: 1, otc: "")
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc1.rawValue, text: "")
                }
            case OTCTextFieldTag.otc2.rawValue:
                if self.otc.isOTCEnteredIn(index: 2) {
                    self.otc.setOTCIn(index: 2, otc: "")
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc2.rawValue, text: "")
                }
            case OTCTextFieldTag.otc3.rawValue:
                if otc.isOTCEnteredIn(index: 3) {
                    self.otc.setOTCIn(index: 3, otc: "")
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc3.rawValue, text: "")
                }
            case OTCTextFieldTag.otc4.rawValue:
                if self.otc.isOTCEnteredIn(index: 4) {
                    self.otc.setOTCIn(index: 4, otc: "")
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc4.rawValue, text: "")
                }
            default:
                return false
            }
            
            self.stayInSameOTCTextField = false
            return true
        }
        
        return false
    }
}

extension OneTimeCodeViewController: TextFieldEditingChangedDelegate {
    func editingChanged(_ textField: UITextField) {
        switch textField.tag {
        case OTCTextFieldTag.otc0.rawValue:
            guard let currentOTC0 = textField.text else { self.otc.setOTCIn(index: 0, otc: ""); return }
            self.otc.setOTCIn(index: 0, otc: currentOTC0)
            let allOTCsEntered = self.otc.isAllOTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc1.rawValue)
            }
        case OTCTextFieldTag.otc1.rawValue:
            guard let currentOTC1 = textField.text else { self.otc.setOTCIn(index: 1, otc: ""); return }
            self.otc.setOTCIn(index: 1, otc: currentOTC1)
            let allOTCsEntered = self.otc.isAllOTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc2.rawValue)
            }
        case OTCTextFieldTag.otc2.rawValue:
            guard let currentOTC2 = textField.text else { self.otc.setOTCIn(index: 2, otc: ""); return }
            self.otc.setOTCIn(index: 2, otc: currentOTC2)
            let allOTCsEntered = self.otc.isAllOTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc3.rawValue)
            }
        case OTCTextFieldTag.otc3.rawValue:
            guard let currentOTC3 = textField.text else { self.otc.setOTCIn(index: 3, otc: ""); return }
            self.otc.setOTCIn(index: 3, otc: currentOTC3)
            let allOTCsEntered = self.otc.isAllOTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
            }
        case OTCTextFieldTag.otc4.rawValue:
            guard let currentOTC4 = textField.text else { self.otc.setOTCIn(index: 4, otc: ""); return }
            self.otc.setOTCIn(index: 4, otc: currentOTC4)
            let allOTCsEntered = self.otc.isAllOTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                textField.resignFirstResponder()
                switch self.otc.getFirstEmptyOTCIndex() {
                case 0:
                    self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc0.rawValue)
                case 1:
                    self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc1.rawValue)
                case 2:
                    self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc2.rawValue)
                case 3:
                    self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc3.rawValue)
                case 4:
                    // can't reach here, just for symmetry
                    self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
                default:
                    break
                }
            }
        default:
            break
        }
    }
}
