//
//  PhoneNumberOTPViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class OneTimeCodeViewController: UIViewController {
    var oneTimeCodeView = OneTimeCodeView()
//    var oneTimeCodeView: someProtocol = OneTimeCodeView()
    
    var otc0 = ""
    var otc1 = ""
    var otc2 = ""
    var otc3 = ""
    var otc4 = ""
    
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

extension OneTimeCodeViewController {
    func isAll5OTCsEntered() -> Bool {
        return self.otc0.count == 1 &&
               self.otc1.count == 1 &&
               self.otc2.count == 1 &&
               self.otc3.count == 1 &&
               self.otc4.count == 1
    }
    
    func getFirstEmptyOTCIndex() -> Int {
        if self.otc0.count < 1 {
            return 0
        }
        if self.otc1.count < 1 {
            return 1
        }
        if self.otc2.count < 1 {
            return 2
        }
        if self.otc3.count < 1 {
            return 3
        }
        if self.otc4.count < 1 {
            return 4
        }
        
        return -1    // logical error
    }
}

extension OneTimeCodeViewController: RegistrationFlowNextDelegate {
    func next() {
        if self.isAll5OTCsEntered() {
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
//                self.oneTimeCodeView.resignTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
                textField.resignFirstResponder()
            default:
                break
            }
            
            return false
        }
        
        if string == "" {
            switch textField.tag {
            case OTCTextFieldTag.otc0.rawValue:
                if self.otc0.count == 1 {
                    self.stayInSameOTCTextField = true
                }
            case OTCTextFieldTag.otc1.rawValue:
                if self.otc1.count == 1 {
                    self.stayInSameOTCTextField = true
                }
            case OTCTextFieldTag.otc2.rawValue:
                if self.otc2.count == 1 {
                    self.stayInSameOTCTextField = true
                }
            case OTCTextFieldTag.otc3.rawValue:
                if self.otc3.count == 1 {
                    self.stayInSameOTCTextField = true
                }
            case OTCTextFieldTag.otc4.rawValue:
                if self.otc4.count == 1 {
                    self.stayInSameOTCTextField = true
                }
            default:
                return false
            }
            
            return true
        }
        
        let digits = "0123456789"
        if digits.contains(string) {
            switch textField.tag {
            case OTCTextFieldTag.otc0.rawValue:
                if self.otc0.count == 1 {
                    self.otc0 = ""
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc0.rawValue, text: "")
                }
            case OTCTextFieldTag.otc1.rawValue:
                if self.otc1.count == 1 {
                    self.otc1 = ""
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc1.rawValue, text: "")
                }
            case OTCTextFieldTag.otc2.rawValue:
                if self.otc2.count == 1 {
                    self.otc2 = ""
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc2.rawValue, text: "")
                }
            case OTCTextFieldTag.otc3.rawValue:
                if self.otc3.count == 1 {
                    self.otc3 = ""
                    self.oneTimeCodeView.setOTCTextFieldWith(tag: OTCTextFieldTag.otc3.rawValue, text: "")
                }
            case OTCTextFieldTag.otc4.rawValue:
                if self.otc4.count == 1 {
                    self.otc4 = ""
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
            guard let currentOTC1 = textField.text else { self.otc0 = ""; return }
            self.otc0 = currentOTC1
            let allOTCsEntered = self.isAll5OTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc1.rawValue)
            }
        case OTCTextFieldTag.otc1.rawValue:
            guard let currentOTC2 = textField.text else { self.otc1 = ""; return }
            self.otc1 = currentOTC2
            let allOTCsEntered = self.isAll5OTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc2.rawValue)
            }
        case OTCTextFieldTag.otc2.rawValue:
            guard let currentOTC3 = textField.text else { self.otc2 = ""; return }
            self.otc2 = currentOTC3
            let allOTCsEntered = self.isAll5OTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc3.rawValue)
            }
        case OTCTextFieldTag.otc3.rawValue:
            guard let currentOTC4 = textField.text else { self.otc3 = ""; return }
            self.otc3 = currentOTC4
            let allOTCsEntered = self.isAll5OTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
            }
        case OTCTextFieldTag.otc4.rawValue:
            guard let currentOTC5 = textField.text else { self.otc4 = ""; return }
            self.otc4 = currentOTC5
            let allOTCsEntered = self.isAll5OTCsEntered()
            if allOTCsEntered {
                textField.resignFirstResponder()
            } else if !stayInSameOTCTextField {
                textField.resignFirstResponder()
                switch self.getFirstEmptyOTCIndex() {
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
