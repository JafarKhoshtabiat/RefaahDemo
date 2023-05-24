//
//  SetPasswordForNewRegistrationViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit

class SetPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var possibleCharactersLabel: UILabel!
    @IBOutlet weak var atleastOneLowerCaseLabel: UILabel!
    @IBOutlet weak var atleastOneUpperCaseLabel: UILabel!
    @IBOutlet weak var atleastOneDigitLabel: UILabel!
    @IBOutlet weak var atleastOneSymbolLabel: UILabel!
    @IBOutlet weak var atleast12LengthLabel: UILabel!
    
    var possibleCharactersCondition = false
    var atleastOneLowerCaseCondition = false
    var atleastOneUpperCaseCondition = false
    var atleastOneDigitCondition = false
    var atleastOneSymbolCondition = false
    var atleast12LengthConfition = false
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        guard let currentTypedPassword = sender.text else { self.resetLabelsColors(); return }
        guard currentTypedPassword != "" else { self.resetLabelsColors(); return }
        self.updatePasswordStatus(currentTypedPassword: currentTypedPassword)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.checkiFCurrentTypedPasswordIsValid() {
            self.performSegue(withIdentifier: "setPasswordToChooseAccountsSegue", sender: nil)
        } else {
            func presentAlert(withTitle title: String, message : String) {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "باشه", style: .default)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            presentAlert(withTitle: "عملیات ناموفق", message: "لطفا کلمه‌عبور معتبر وارد کنید.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordTextField.delegate = self
        
        self.passwordTextField.layer.cornerRadius = 20
        self.passwordTextField.layer.borderWidth = 2
        self.passwordTextField.layer.borderColor = CGColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.passwordTextField.clipsToBounds = true
        
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
    
    func isEnteredCharAllowed(enteredChar: Character) -> Bool {
        return self.isLowerCaseLetter(char: enteredChar) ||
            self.isUpperCaseLetter(char: enteredChar)    ||
            self.isDigit(char: enteredChar)              ||
            self.isAllowedSymbol(char: enteredChar)
    }
    
    func updatePasswordStatus(currentTypedPassword: String) {
        self.possibleCharactersCondition = self.isCurrentTypedPasswordHasOnlyAllowedChars(currentTypedPassword: currentTypedPassword)
        self.atleastOneLowerCaseCondition = self.isCurrentTypedPasswordHasAtleastOneLowerCase(currentTypedPassword: currentTypedPassword)
        self.atleastOneUpperCaseCondition = self.isCurrentTypedPasswordHasAtleastOneUpperCase(currentTypedPassword: currentTypedPassword)
        self.atleastOneDigitCondition = self.isCurrentTypedPasswordHasAtleastOneDigit(currentTypedPassword: currentTypedPassword)
        self.atleastOneSymbolCondition = self.isCurrentTypedPasswordHasAtleastOneSymbol(currentTypedPassword: currentTypedPassword)
        self.atleast12LengthConfition = self.isCurrentTypedPasswordHasAtleast12Length(currentTypedPassword: currentTypedPassword)
        
        self.updatePasswordStatusLabelsColors()
    }
    
    func updatePasswordStatusLabelsColors() {
        self.updatePossibleCharactersLabelColor()
        self.updateAtleastOneLowerCaseLabelColor()
        self.updateAtleastOneUpperCaseLabelColor()
        self.updateAtleastOneDigitLabelColor()
        self.updateAtleastOneSymbolLabelColor()
        self.updateAtleast12LengthLabelColor()
    }
    
    func updatePossibleCharactersLabelColor() {
        if self.possibleCharactersCondition {
            self.possibleCharactersLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.possibleCharactersLabel.textColor = UIColor(named: "Flame Hawkfish")
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
    
    func updateAtleastOneLowerCaseLabelColor() {
        if self.atleastOneLowerCaseCondition {
            self.atleastOneLowerCaseLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.atleastOneLowerCaseLabel.textColor = UIColor(named: "Flame Hawkfish")
        }
    }
    
    func isCurrentTypedPasswordHasAtleastOneLowerCase(currentTypedPassword: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: currentTypedPassword)
        
    }
    
    func updateAtleastOneUpperCaseLabelColor() {
        if self.atleastOneUpperCaseCondition {
            self.atleastOneUpperCaseLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.atleastOneUpperCaseLabel.textColor = UIColor(named: "Flame Hawkfish")
        }
    }
    
    func isCurrentTypedPasswordHasAtleastOneUpperCase(currentTypedPassword: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: currentTypedPassword)
    }
    
    func updateAtleastOneDigitLabelColor() {
        if self.atleastOneDigitCondition {
            self.atleastOneDigitLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.atleastOneDigitLabel.textColor = UIColor(named: "Flame Hawkfish")
        }
    }
    
    func isCurrentTypedPasswordHasAtleastOneDigit(currentTypedPassword: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: currentTypedPassword)
    }
    
    func updateAtleastOneSymbolLabelColor() {
        if self.atleastOneSymbolCondition {
            self.atleastOneSymbolLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.atleastOneSymbolLabel.textColor = UIColor(named: "Flame Hawkfish")
        }
    }
    
    func isCurrentTypedPasswordHasAtleastOneSymbol(currentTypedPassword: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", ".*[!&^%$#@()]+.*").evaluate(with: currentTypedPassword)
    }
    
    func updateAtleast12LengthLabelColor() {
        if self.atleast12LengthConfition {
            self.atleast12LengthLabel.textColor = UIColor(named: "GreenJungle")
        } else {
            self.atleast12LengthLabel.textColor = UIColor(named: "Flame Hawkfish")
        }
    }
    
    func isCurrentTypedPasswordHasAtleast12Length(currentTypedPassword: String) -> Bool {
        return currentTypedPassword.count >= 12
    }
    
    func resetLabelsColors() {
        self.possibleCharactersLabel.textColor = UIColor.black
        self.atleastOneLowerCaseLabel.textColor = UIColor.black
        self.atleastOneUpperCaseLabel.textColor = UIColor.black
        self.atleastOneDigitLabel.textColor = UIColor.black
        self.atleastOneSymbolLabel.textColor = UIColor.black
        self.atleast12LengthLabel.textColor = UIColor.black
    }
    
    func checkiFCurrentTypedPasswordIsValid() -> Bool {
        return  self.possibleCharactersCondition &&
            self.atleastOneLowerCaseCondition    &&
            self.atleastOneUpperCaseCondition    &&
            self.atleastOneDigitCondition        &&
            self.atleastOneSymbolCondition       &&
            self.atleast12LengthConfition
    }
}

extension SetPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " else { return false }
        guard string != "\n" else {
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
}
