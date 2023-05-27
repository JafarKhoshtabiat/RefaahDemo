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
    
    @IBOutlet weak var otc0TextField: UITextField!
    @IBOutlet weak var otc1TextField: UITextField!
    @IBOutlet weak var otc2TextField: UITextField!
    @IBOutlet weak var otc3TextField: UITextField!
    @IBOutlet weak var otc4TextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var otc0 = ""
    var otc1 = ""
    var otc2 = ""
    var otc3 = ""
    var otc4 = ""
    
    var stayInSameOTC = false
    
    @IBAction func otc1TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC1 = sender.text else { self.otc0 = ""; return }
        
        self.otc0 = currentOTC1
//        if let shouldGoBack = self.shouldGoBack {
//            if !shouldGoBack {
//                self.otc2TextField.becomeFirstResponder()
//            }
//        }
        
        if !stayInSameOTC {
            self.otc1TextField.becomeFirstResponder()
        }
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc2TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC2 = sender.text else { self.otc1 = ""; return }
        
        self.otc1 = currentOTC2
//        if let shouldGoBack = self.shouldGoBack {
//            if shouldGoBack {
//                self.otc1TextField.becomeFirstResponder()
//            } else {
//                self.otc3TextField.becomeFirstResponder()
//            }
//        }
        if !stayInSameOTC {
            self.otc2TextField.becomeFirstResponder()
        }
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc3TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC3 = sender.text else { self.otc2 = ""; return }
        
        self.otc2 = currentOTC3
//        if let shouldGoBack = self.shouldGoBack {
//            if shouldGoBack {
//                self.otc2TextField.becomeFirstResponder()
//            } else {
//                self.otc4TextField.becomeFirstResponder()
//            }
//        }
        if !stayInSameOTC {
            self.otc3TextField.becomeFirstResponder()
        }
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc4TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC4 = sender.text else { self.otc3 = ""; return }
        
        self.otc3 = currentOTC4
//        if let shouldGoBack = self.shouldGoBack {
//            if shouldGoBack {
//                self.otc3TextField.becomeFirstResponder()
//            } else {
//                self.otc5TextField.becomeFirstResponder()
//            }
//        }
        if !stayInSameOTC {
            self.otc4TextField.becomeFirstResponder()
        }
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc5TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC5 = sender.text else { self.otc4 = ""; return }
        
        self.otc4 = currentOTC5
//        if let shouldGoBack = self.shouldGoBack {
//            if shouldGoBack {
//                self.otc4TextField.becomeFirstResponder()
//            } else {
//                self.otc5TextField.resignFirstResponder()
//            }
//        }
        if !stayInSameOTC {
            self.otc4TextField.resignFirstResponder()
        }
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "otpToNationalIdSegue", sender: nil)
    }
    
    func isAll5OTCsEntered() -> Bool {
        return self.otc0.count == 1 &&
               self.otc1.count == 1 &&
               self.otc2.count == 1 &&
               self.otc3.count == 1 &&
               self.otc4.count == 1
    }
    
    func showNextButtonIfAllOTCsEntered() {
        if self.isAll5OTCsEntered() {
            self.nextButton.isHidden = false
        } else {
            self.nextButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self.oneTimeCodeView.resignTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
            default:
                break
            }
            
            return false
        }
        
        if string == "" {
            switch textField.tag {
            case OTCTextFieldTag.otc0.rawValue:
                if self.otc0.count == 1 {
                    self.stayInSameOTC = true
                }
            case OTCTextFieldTag.otc1.rawValue:
                if self.otc1.count == 1 {
                    self.stayInSameOTC = true
                }
            case OTCTextFieldTag.otc2.rawValue:
                if self.otc2.count == 1 {
                    self.stayInSameOTC = true
                }
            case OTCTextFieldTag.otc3.rawValue:
                if self.otc3.count == 1 {
                    self.stayInSameOTC = true
                }
            case OTCTextFieldTag.otc4.rawValue:
                if self.otc4.count == 1 {
                    self.stayInSameOTC = true
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
            
            self.stayInSameOTC = false
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
            if !stayInSameOTC {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc1.rawValue)
            }
        case OTCTextFieldTag.otc1.rawValue:
            guard let currentOTC2 = textField.text else { self.otc1 = ""; return }
            self.otc1 = currentOTC2
            if !stayInSameOTC {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc2.rawValue)
            }
        case OTCTextFieldTag.otc2.rawValue:
            guard let currentOTC3 = textField.text else { self.otc2 = ""; return }
            self.otc2 = currentOTC3
            if !stayInSameOTC {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc3.rawValue)
            }
        case OTCTextFieldTag.otc3.rawValue:
            guard let currentOTC4 = textField.text else { self.otc3 = ""; return }
            self.otc3 = currentOTC4
            if !stayInSameOTC {
                self.oneTimeCodeView.makeTextFieldFirstResponderWith(tag: OTCTextFieldTag.otc4.rawValue)
            }
        case OTCTextFieldTag.otc4.rawValue:
            guard let currentOTC5 = textField.text else { self.otc4 = ""; return }
            self.otc4 = currentOTC5
            if !stayInSameOTC {
                textField.resignFirstResponder()
            }
        default:
            break
        }
    }
}

enum OTCTextFieldTag: Int {
    case otc0 = 10000
    case otc1 = 10001
    case otc2 = 10002
    case otc3 = 10003
    case otc4 = 10004
}
