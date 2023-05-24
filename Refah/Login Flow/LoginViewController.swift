//
//  LoginViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/27/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var faraRefahLoginImage: UIImageView!
    
    @IBOutlet weak var inputViewUIView: UIView!
    @IBOutlet weak var nationalIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var fingerPrintButton: UIButton!
    
    var nationalCodeIsValid = false
    var passwordIsValid = false
    
    @IBAction func nationalIdTextFieldEditingChanged(_ sender: UITextField) {
        guard let currentText = sender.text else { return }
        
        if currentText.count == "1234567890".count {
            self.nationalCodeIsValid = true
            
            self.nationalIdTextField.resignFirstResponder()
        } else if currentText.count > "1234567890".count {
            self.nationalCodeIsValid = false
        } else {
            self.nationalCodeIsValid = false
        }
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        guard let currentTypedPassword = sender.text else { return }
        print(currentTypedPassword)
        let atleast12LengthConfition = (currentTypedPassword.count >= 12)
        let possibleCharactersCondition = self.isCurrentTypedPasswordHasOnlyAllowedChars(currentTypedPassword: currentTypedPassword)
        let atleastOneLowerCaseCondition = NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: currentTypedPassword)
        let atleastOneUpperCaseCondition = NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: currentTypedPassword)
        let atleastOneDigitCondition = NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: currentTypedPassword)
        let atleastOneSymbolCondition = NSPredicate(format:"SELF MATCHES %@", ".*[!&^%$#@()]+.*").evaluate(with: currentTypedPassword)
        
        self.passwordIsValid = atleast12LengthConfition &&
                            possibleCharactersCondition &&
                           atleastOneLowerCaseCondition &&
                           atleastOneUpperCaseCondition &&
                               atleastOneDigitCondition &&
                              atleastOneSymbolCondition
    }
    
    @IBAction func showPasswordButtonPressed(_ sender: UIButton) {
        let temp = self.passwordTextField.isSecureTextEntry
        self.passwordTextField.isSecureTextEntry = !temp
    }
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var topStatusImage: UIImageView!
    @IBOutlet weak var topStatusText: UILabel!
    @IBOutlet weak var middleStatusImage: UIImageView!
    @IBOutlet weak var middleStatusText: UILabel!
    @IBOutlet weak var bottomStatusImage: UIImageView!
    @IBOutlet weak var bottomStatusText: UILabel!
    
    @IBOutlet weak var topSeperatorLine: UIView!
    @IBOutlet weak var bottomSeperatorLine: UIView!
    
    @IBOutlet weak var topActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var middleActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomActivityIndicator: UIActivityIndicatorView!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if self.nationalCodeIsValid && self.passwordIsValid {
            self.shadowView.isHidden = false
            self.statusView.isHidden = false
            
            self.topActivityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.topActivityIndicator.stopAnimating()
                self.topStatusImage.isHidden = false
                self.topStatusText.text = "اتمام موفق احراز هویت و ورود"
                self.topSeperatorLine.isHidden = false
                self.middleActivityIndicator.startAnimating()
                self.middleStatusText.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.middleActivityIndicator.stopAnimating()
                    self.middleStatusImage.isHidden = false
                    self.middleStatusText.text = "اتمام دریافت موفق اطلاعات حساب"
                    self.bottomSeperatorLine.isHidden = false
                    self.bottomActivityIndicator.startAnimating()
                    self.bottomStatusText.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.bottomActivityIndicator.stopAnimating()
                        self.bottomStatusImage.isHidden = false
                        self.bottomStatusText.text = "اتمام دریافت موفق اطلاعات کارت"
                        self.performSegue(withIdentifier: "loginSegueId", sender: nil)
                    }
                }
            }
        } else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "کدملی یا کلمه‌عبور معتبر نیست.", style: UIAlertController.Style.alert, okActionTitle: "متوجه شدم", okActionCompletion: { _ in })
        }
    }
    
    func isCurrentTypedPasswordHasOnlyAllowedChars(currentTypedPassword: String) -> Bool {
        for char in currentTypedPassword {
            if !self.isEnteredCharAllowed(enteredChar: char) {
                return false
            }
        }
        
        return true
    }
    
    func isEnteredCharAllowed(enteredChar: Character) -> Bool {
        return self.isLowerCaseLetter(char: enteredChar) ||
            self.isUpperCaseLetter(char: enteredChar)    ||
            self.isDigit(char: enteredChar)              ||
            self.isAllowedSymbol(char: enteredChar)
    }
    
    func isLowerCaseLetter(char: Character) -> Bool {
        let lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz"
        return lowerCaseLetters.contains(char)
    }
    
    func isUpperCaseLetter(char: Character) -> Bool {
        let upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return upperCaseLetters.contains(char)
    }
    
    func isDigit(char: Character) -> Bool {
        let digits = "0123456789"
        return digits.contains(char)
    }
    
    func isAllowedSymbol(char: Character) -> Bool {
        let allowedSymbols = "!&^%$#@()"
        return allowedSymbols.contains(char)
    }
    
    func loadImage() {
        self.faraRefahLoginImage?.image = UIImage(named: "FaraRefah_Login")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadImage()
        
        self.inputViewUIView.layer.cornerRadius = 20
        
        self.nationalIdTextField.delegate = self
        self.nationalIdTextField.tag = 1000
        self.nationalIdTextField.backgroundColor = .white
        self.nationalIdTextField.layer.cornerRadius = 20
        self.nationalIdTextField.layer.borderWidth = 2
        self.nationalIdTextField.layer.borderColor = CGColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        self.nationalIdTextField.clipsToBounds = true
        
        self.passwordTextField.delegate = self
        self.passwordTextField.tag = 2000
        self.passwordTextField.backgroundColor = .white
        self.passwordTextField.layer.cornerRadius = 20
        self.passwordTextField.layer.borderWidth = 2
        self.passwordTextField.layer.borderColor = CGColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        self.passwordTextField.clipsToBounds = true
        
        self.loginButton.layer.cornerRadius = 20
        
        let forgetPasswordPersianString = "فراموشی رمز عبور"
        let color = UIColor(red: 84/255, green: 92/255, blue: 102/255, alpha: 1)
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 12),
              .foregroundColor: color,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ] // .double.rawValue, .thick.rawValue
        let attributeString = NSMutableAttributedString(
                string: forgetPasswordPersianString,
                attributes: yourAttributes
             )
        self.forgetPasswordButton.setAttributedTitle(attributeString, for: .normal)
        
        self.statusView.layer.cornerRadius = 20
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

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " else { return false }
        guard string != "\n" else {
            textField.resignFirstResponder()
            return false
        }
        
        if textField.tag == 1000 {    // nationalIdTextField
            if string == "" {
                return true
            }
            
            let digits = "0123456789"
            if digits.contains(string) {
                return true
            }
        } else if textField.tag == 2000 {    // passwordTextField
            return true
        }
        
        return false
    }
}
