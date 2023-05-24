//
//  NationalCodeViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/1/23.
//

import UIKit

class NationalCodeViewController: UIViewController {

    @IBOutlet weak var nationalCodeTextField: UITextField!
    @IBOutlet weak var nationalCodeValidLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var nationalCodeIsValid = false
    
    @IBAction func nationalcodeTextFieldEditingChanged(_ sender: UITextField) {
        guard let currentText = sender.text else { self.nationalCodeValidLabel.isHidden = true; return }
        
        if currentText.count == "1234567890".count {
            self.nationalCodeIsValid = true
            
            self.nationalCodeValidLabel.text = "کدملی واردشده معتبر است."
            self.nationalCodeValidLabel.textColor = UIColor(named: "GreenJungle")
            self.nationalCodeValidLabel.isHidden = false
            self.nationalCodeTextField.resignFirstResponder()
        } else if currentText.count > "1234567890".count {
            self.nationalCodeIsValid = false
            
            self.nationalCodeValidLabel.text = "کدملی وارد‌شده معتبر نیست."
            self.nationalCodeValidLabel.textColor = UIColor(named: "Flame Hawkfish")
            self.nationalCodeValidLabel.isHidden = false
        } else {
            self.nationalCodeIsValid = false
            
            self.nationalCodeValidLabel.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.nationalCodeIsValid {
            self.performSegue(withIdentifier: "nationalCodeToNationalCardPhotoSegue", sender: nil)
        } else {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "کدملی واردشده معتبر نیست.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nationalCodeTextField.delegate = self
        
        self.nationalCodeTextField.layer.cornerRadius = 20
        self.nationalCodeTextField.layer.borderWidth = 2
        self.nationalCodeTextField.layer.borderColor = CGColor(red: 88/255, green:88/255, blue: 88/255, alpha: 1)
        self.nationalCodeTextField.clipsToBounds = true
        
        self.nextButton.layer.cornerRadius = 20
        
        self.nationalCodeValidLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.nationalCodeTextField.becomeFirstResponder()
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
