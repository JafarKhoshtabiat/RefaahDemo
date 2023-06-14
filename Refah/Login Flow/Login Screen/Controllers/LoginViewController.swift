//
//  LoginViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/27/23.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    private let loginView: LoginViewProtocol = LoginView()
    
    var nationalCodeIsValid = false
    var passwordIsValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginView.textFieldsEditingChangedDelegate = self
        self.loginView.textFieldsDelegate = self
        self.loginView.buttonsTouchUpInsideDelegate = self
    }
    
    override func loadView() {
        self.view = self.loginView
    }
}

extension LoginViewController {
    private func startLoginProcess() {
        self.loginView.showShadowView()
        self.loginView.showPendingView()
        self.loginView.startAnimatingFirstActivityIndicator()
        self.loginView.setFirstLabelText(text: "درحال احراز هویت و ورود...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loginView.stopAnimatingFirstActivityIndicator()
            self.loginView.showFirstImageView()
            self.loginView.setFirstLabelText(text: "اتمام موفق احراز هویت و ورود")
            self.loginView.startAnimatingSecondActivityIndicator()
            self.loginView.setSecondLabelText(text: "درحال دریاف اطلاعات حساب...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.loginView.stopAnimatingSecondActivityIndicator()
                self.loginView.showSecondImageView()
                self.loginView.setSecondLabelText(text: "اتمام دریافت موفق اطلاعات حساب")
                self.loginView.startAnimatingThirdActivityIndicator()
                self.loginView.setThirdLabelText(text: "درحال دریافت اطلاعات کارت...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.loginView.stopAnimatingThirdActivityIndicator()
                    self.loginView.showThirdImageView()
                    self.loginView.setThirdLabelText(text: "اتمام دریافت موفق اطلاعات کارت")
                    self.performSegue(withIdentifier: "Login_To_Dummy", sender: nil)
                }
            }
        }
    }
    
    private func isCurrentTypedPasswordHasOnlyAllowedChars(currentTypedPassword: String) -> Bool {
        for char in currentTypedPassword {
            if !self.isEnteredCharAllowed(enteredChar: char) {
                return false
            }
        }
        
        return true
    }
    
    private func isEnteredCharAllowed(enteredChar: Character) -> Bool {
        return self.isLowerCaseLetter(char: enteredChar) ||
            self.isUpperCaseLetter(char: enteredChar)    ||
            self.isDigit(char: enteredChar)              ||
            self.isAllowedSymbol(char: enteredChar)
    }
    
    private func isLowerCaseLetter(char: Character) -> Bool {
        let lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz"
        return lowerCaseLetters.contains(char)
    }
    
    private func isUpperCaseLetter(char: Character) -> Bool {
        let upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return upperCaseLetters.contains(char)
    }
    
    private func isDigit(char: Character) -> Bool {
        let digits = "0123456789"
        return digits.contains(char)
    }
    
    private func isAllowedSymbol(char: Character) -> Bool {
        let allowedSymbols = "!&^%$#@()"
        return allowedSymbols.contains(char)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != " " else { return false }
        guard string != "\n" else {
            textField.resignFirstResponder()
            return false
        }
        
        if textField.tag == LoginScreenTextFieldTag.nationalCodeTextFieldTag.rawValue {    // nationalIdTextField
            if string == "" {
                return true
            }
            
            let digits = "0123456789"
            if digits.contains(string) {
                return true
            }
        } else if textField.tag == LoginScreenTextFieldTag.passwordTextFieldTag.rawValue {    // passwordTextField
            return true
        }
        
        return false
    }
}

extension LoginViewController: LoginViewTextFieldsEditingChangedDelegate {
    func nationalCodeTextFieldEditingChanged(_ textField: UITextField) {
        guard let currentText = textField.text else { return }
        print(currentText)
        if currentText.count == "1234567890".count {
            self.nationalCodeIsValid = true
            textField.resignFirstResponder()
        } else if currentText.count > "1234567890".count {
            self.nationalCodeIsValid = false
        } else {
            self.nationalCodeIsValid = false
        }
    }
    
    func passwordTextFieldEditingChanged(_ textField: UITextField) {
        guard let currentTypedPassword = textField.text else { return }
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
}

extension LoginViewController: LoginViewButtonsTouchUpInsideDelegate {
    func loginButtonDidTouchUpInside() {
        if self.nationalCodeIsValid && self.passwordIsValid {
            self.startLoginProcess()
        } else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "کدملی یا کلمه‌عبور معتبر نیست.", style: UIAlertController.Style.alert, okActionTitle: "متوجه شدم", okActionCompletion: { _ in })
        }
    }
    
    func fingerPrintButtonDidTouchUpInside() {
        let context = LAContext()
        context.localizedCancelTitle = "وارد کردن کدملی و رمزعبور"
        var error: NSError?
        var errorMessage = ""
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            switch error?.code {
            case LAError.Code.biometryLockout.rawValue:    // biometry locked out, user must enter passcode to enable it
                self.tryToEnableFingerPrintWithPassCode(context: context)
                return
            case LAError.Code.biometryNotEnrolled.rawValue, LAError.Code.biometryNotAvailable.rawValue:
                errorMessage = "ورود فقط با وارد کردن کدملی و رمزعبور امکان‌پذیر است."
            default:
                errorMessage = String(describing: error?.localizedDescription)
                
            }
            self.presentUIAlertController(title: "",
                                          titleColor: UIColor.flameHawkfish,
                                          message: errorMessage,
                                          style: UIAlertController.Style.alert,
                                          okActionTitle: "متوجه شدم",
                                          okActionCompletion: { _ in })
            return
        }
        self.biometryAuthentication(context: context)
    }
    
    func tryToEnableFingerPrintWithPassCode(context: LAContext) {
        Task {
            let _ = try? await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "برای فعال شدن ورود با اثر انگشت گذرواژه را وارد کنید.")
        }
    }
    
    func biometryAuthentication(context: LAContext) {
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "ورود به حساب کاربری")
                self.startLoginProcess()
            } catch let error {
                var errorMessage = ""
                guard let localAuthError = error as? LAError else {
                    self.presentUIAlertController(title: "",
                                                  titleColor: UIColor.flameHawkfish,
                                                  message: error.localizedDescription,
                                                  style: UIAlertController.Style.alert,
                                                  okActionTitle: "متوجه شدم",
                                                  okActionCompletion: { _ in })
                    return
                }
                switch localAuthError.code.rawValue {
                case LAError.authenticationFailed.rawValue:    // -1
                    errorMessage = "احراز هویت ناموفق بود."
                case LAError.biometryLockout.rawValue:
                    if context.biometryType == .faceID {
                        errorMessage = "برای احراز هویت با face Id  وارد کردن passcode الزامی است."
                    } else if context.biometryType == .touchID {
                        errorMessage = "برای احراز هویت با touch Id وارد کردن passcode الزامی است."
                    } else {
                        errorMessage = "وارد کردن passcode الزامی است."
                    }
                default:
                    // print(localAuthError.code.rawValue)
                    errorMessage = error.localizedDescription
                }
                self.presentUIAlertController(title: "",
                                              titleColor: UIColor.flameHawkfish,
                                              message: errorMessage,
                                              style: UIAlertController.Style.alert,
                                              okActionTitle: "متوجه شدم",
                                              okActionCompletion: { _ in })
            }
        }
    }
}
