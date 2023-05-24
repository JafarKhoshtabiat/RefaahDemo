//
//  PhoneNumberOTPViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/30/23.
//

import UIKit

class PhoneNumberOTPViewController: UIViewController {

    @IBOutlet weak var otc1TextField: UITextField!
    @IBOutlet weak var otc2TextField: UITextField!
    @IBOutlet weak var otc3TextField: UITextField!
    @IBOutlet weak var otc4TextField: UITextField!
    @IBOutlet weak var otc5TextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    let otc1TextFieldTag = 1000
    let otc2TextFieldTag = 2000
    let otc3TextFieldTag = 3000
    let otc4TextFieldTag = 4000
    let otc5TextFieldTag = 5000
    
    var otc1 = ""
    var otc2 = ""
    var otc3 = ""
    var otc4 = ""
    var otc5 = ""
    
    var shouldGoBack: Bool? = nil
    
    @IBAction func otc1TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC1 = sender.text else { self.otc1 = ""; return }
        
        self.otc1 = currentOTC1
        if let shouldGoBack = self.shouldGoBack {
            if !shouldGoBack {
                self.otc2TextField.becomeFirstResponder()
            }
        }
        
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc2TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC2 = sender.text else { self.otc2 = ""; return }
        
        self.otc2 = currentOTC2
        if let shouldGoBack = self.shouldGoBack {
            if shouldGoBack {
                self.otc1TextField.becomeFirstResponder()
            } else {
                self.otc3TextField.becomeFirstResponder()
            }
        }
        
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc3TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC3 = sender.text else { self.otc3 = ""; return }
        
        self.otc3 = currentOTC3
        if let shouldGoBack = self.shouldGoBack {
            if shouldGoBack {
                self.otc2TextField.becomeFirstResponder()
            } else {
                self.otc4TextField.becomeFirstResponder()
            }
        }
        
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc4TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC4 = sender.text else { self.otc4 = ""; return }
        
        self.otc4 = currentOTC4
        if let shouldGoBack = self.shouldGoBack {
            if shouldGoBack {
                self.otc3TextField.becomeFirstResponder()
            } else {
                self.otc5TextField.becomeFirstResponder()
            }
        }
        
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func otc5TextFieldEditingChanged(_ sender: UITextField) {
        guard let currentOTC5 = sender.text else { self.otc5 = ""; return }
        
        self.otc5 = currentOTC5
        if let shouldGoBack = self.shouldGoBack {
            if shouldGoBack {
                self.otc4TextField.becomeFirstResponder()
            } else {
                self.otc5TextField.resignFirstResponder()
            }
        }
        
        self.showNextButtonIfAllOTCsEntered()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "otpToNationalIdSegue", sender: nil)
    }
    
    func isAll5OTCsEntered() -> Bool {
        return self.otc1.count == 1 &&
               self.otc2.count == 1 &&
               self.otc3.count == 1 &&
               self.otc4.count == 1 &&
               self.otc5.count == 1
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
        
        self.otc1TextField.delegate = self
        self.otc1TextField.tag = otc1TextFieldTag
        
        self.otc1TextField.layer.cornerRadius = 5
        self.otc1TextField.layer.borderWidth = 2
        self.otc1TextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        
        self.otc2TextField.delegate = self
        self.otc2TextField.tag = otc2TextFieldTag
        
        self.otc2TextField.layer.cornerRadius = 5
        self.otc2TextField.layer.borderWidth = 2
        self.otc2TextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        
        self.otc3TextField.delegate = self
        self.otc3TextField.tag = otc3TextFieldTag
        
        self.otc3TextField.layer.cornerRadius = 5
        self.otc3TextField.layer.borderWidth = 2
        self.otc3TextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        
        self.otc4TextField.delegate = self
        self.otc4TextField.tag = otc4TextFieldTag
        
        self.otc4TextField.layer.cornerRadius = 5
        self.otc4TextField.layer.borderWidth = 2
        self.otc4TextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        
        self.otc5TextField.delegate = self
        self.otc5TextField.tag = otc5TextFieldTag
        
        self.otc5TextField.layer.cornerRadius = 5
        self.otc5TextField.layer.borderWidth = 2
        self.otc5TextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.otc1TextField.becomeFirstResponder()
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

extension PhoneNumberOTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " || string != "\n" else {
            switch textField.tag {
            case self.otc1TextFieldTag:
                self.otc2TextField.becomeFirstResponder()
            case self.otc2TextFieldTag:
                self.otc3TextField.becomeFirstResponder()
            case self.otc3TextFieldTag:
                self.otc4TextField.becomeFirstResponder()
            case self.otc4TextFieldTag:
                self.otc5TextField.becomeFirstResponder()
            case self.otc5TextFieldTag:
                self.otc5TextField.resignFirstResponder()
            default:
                break
            }
            
            return false
        }
        
        if string == "" {
            switch textField.tag {
            case self.otc1TextFieldTag:
                if self.otc1.count == 1 {
                    self.shouldGoBack = nil
                }
            case self.otc2TextFieldTag:
                if self.otc2.count == 1 {
                    self.shouldGoBack = nil
                }
            case self.otc3TextFieldTag:
                if self.otc3.count == 1 {
                    self.shouldGoBack = nil
                }
            case self.otc4TextFieldTag:
                if self.otc4.count == 1 {
                    self.shouldGoBack = nil
                }
            case self.otc5TextFieldTag:
                if self.otc5.count == 1 {
                    self.shouldGoBack = nil
                }
            default:
                return false
            }

            return true
        }
        
        let digits = "0123456789"
        if digits.contains(string) {
            switch textField.tag {
            case self.otc1TextFieldTag:
                if self.otc1.count == 1 {
                    self.otc1 = ""
                    self.otc1TextField.text = ""
                }
            case self.otc2TextFieldTag:
                if self.otc2.count == 1 {
                    self.otc2 = ""
                    self.otc2TextField.text = ""
                }
            case self.otc3TextFieldTag:
                if self.otc3.count == 1 {
                    self.otc3 = ""
                    self.otc3TextField.text = ""
                }
            case self.otc4TextFieldTag:
                if self.otc4.count == 1 {
                    self.otc4 = ""
                    self.otc4TextField.text = ""
                }
            case self.otc5TextFieldTag:
                if self.otc5.count == 1 {
                    self.otc5 = ""
                    self.otc5TextField.text = ""
                }
            default:
                return false
            }
            
            self.shouldGoBack = false
            return true
        }
        
        return false
    }
    
    
}
