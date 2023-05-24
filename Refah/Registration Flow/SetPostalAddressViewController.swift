//
//  SetPostalAddressViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/2/23.
//

import UIKit

class SetPostalAddressViewController: UIViewController {

    @IBOutlet weak var pickStateButton: UIButton!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var pickCityButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var postalCodeValidLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    enum PickingStatus {
        case states
        case cities
        case none
    }
    
    var pickingStatus = PickingStatus.none
    
    var states: [[String: Any]] = [[:]]
    var cities: [[String: Any]] = [[:]]
    var currentStateIndex = -1
    var currentCityIndex = -1
    
    @IBAction func pickStateButtonPressed(_ sender: UIButton) {
        self.pickingStatus = .states
        self.shadowView.isHidden = false
        self.activityIndicator.startAnimating()
        
        
        // var url = URLComponents(string: "https://www.google.com/search/")!

        // url.queryItems = [
           // URLQueryItem(name: "q", value: "War & Peace")
        //]
        
        func sendRequest(_ url: String, parameters: [String: String], completion: @escaping ([[String: Any]]?, Error?) -> Void) {
            var components = URLComponents(string: url)!
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            let request = URLRequest(url: components.url!)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let data = data,                              // is there data
                    let response = response as? HTTPURLResponse,  // is there HTTP response
                    200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                    error == nil                                  // was there no error
                else {
                    completion(nil, error)
                    return
                }
                
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]]
                completion(responseObject, nil)
            }
            task.resume()
        }
        
        func getStates(success: @escaping ([[String: Any]]?) -> (), failure: @escaping (Error?) -> ()) {
            let url = "https://2f75a499-9ef2-43a4-b6e5-838bb827258c.mock.pstmn.io/states"
        
            let urlComponents = URLComponents(string: url)!
            let urlRequest = URLRequest(url: urlComponents.url!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,                              // is there data
                      let response = response as? HTTPURLResponse,  // is there HTTP response
                      200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                      error == nil else { failure(error); return }
                
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]]
                success(responseObject)
            }
            task.resume()
        }
        
        getStates(success: { responseDic in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            self.states = responseDic ?? [[:]]
            DispatchQueue.main.async {
                if self.currentStateIndex != -1 {
                    self.pickerView.selectRow(self.currentStateIndex, inComponent: 0, animated: false)
                }
                self.pickerView.reloadAllComponents()
                self.pickerView.isHidden = false
                self.confrimButton.isHidden = false
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                self.pickingStatus = .none
                self.pickerView.isHidden = true
                self.shadowView.isHidden = true
                self.confrimButton.isHidden = true
                
                self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: error?.localizedDescription ?? "خطای غیرمنتظره")
            }
            
        })
    }
    
    
    @IBAction func pickCityButtonPressed(_ sender: UIButton) {
        guard self.currentStateIndex >= 0 else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا ابتدا استان را انتخاب کنید.")
            return
        }
        
        self.pickingStatus = .cities
        self.shadowView.isHidden = false
        self.activityIndicator.startAnimating()
        
        let stateId = self.states[currentStateIndex]["id"] as? Int
        
        func getCities(success: @escaping ([[String: Any]]?) -> (), failure: @escaping (Error?) -> ()) {
            let url = "https://d9001e47-df90-47f2-9b30-3c05628731e6.mock.pstmn.io/states/cities"
            var urlComponents = URLComponents(string: url)!
            urlComponents.queryItems = [URLQueryItem(name: "stateid", value: "\(stateId ?? -1)")]
            let urlRequest = URLRequest(url: urlComponents.url!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,                              // is there data
                      let response = response as? HTTPURLResponse,  // is there HTTP response
                      200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                      error == nil else { failure(error); return }
                
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]]
                success(responseObject)
            }
            task.resume()
        }
        
        getCities(success: { responseDic in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }

            self.cities = responseDic ?? [[:]]
            DispatchQueue.main.async {
                if self.currentCityIndex != -1 {
                    self.pickerView.selectRow(self.currentCityIndex, inComponent: 0, animated: false)
                }
                self.pickerView.reloadAllComponents()
                self.pickerView.isHidden = false
                self.confrimButton.isHidden = false
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                self.pickingStatus = .none
                self.pickerView.isHidden = true
                self.shadowView.isHidden = true
                self.confrimButton.isHidden = true
                
                self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: error?.localizedDescription ?? "خطای غیرمنتظره")
            }
        })
    }
    
    var postalCodeIsValid = false
    var postalCode: String = ""
    
    @IBAction func postalCodeEditingChanged(_ sender: UITextField) {
        guard let currentText = sender.text else { return }
        
        if currentText.count == "1234567890".count {
            self.postalCodeIsValid = true
            self.postalCode = currentText
            
            self.postalCodeValidLabel.text = "کدپستی واردشده معتبر است."
            self.postalCodeValidLabel.textColor = UIColor(named: "GreenJungle")
            self.postalCodeValidLabel.isHidden = false
            self.postalCodeTextField.resignFirstResponder()
        } else if currentText.count > "1234567890".count {
            self.postalCodeIsValid = false
            
            self.postalCodeValidLabel.text = "کدپستی وارد‌شده معتبر نیست."
            self.postalCodeValidLabel.textColor = UIColor(named: "Flame Hawkfish")
            self.postalCodeValidLabel.isHidden = false
        } else {
            self.postalCodeIsValid = false
            
            self.postalCodeValidLabel.isHidden = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard self.currentStateIndex != -1 else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا استان محل سکونت خود را انتخاب کنید.")
            return
        }
        
        guard self.currentCityIndex != -1 else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا شهر محل سکونت خود را انتخاب کنید.")
            return
        }
        
        guard self.postalCodeIsValid else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا کدپستی معتبر وارد کنید.")
            return
        }
        
        guard self.currentStateIndex >= 0 else {
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا ابتدا استان را انتخاب کنید.")
            return
        }
        
        self.shadowView.isHidden = false
        self.activityIndicator.startAnimating()
        
        let stateId = self.states[currentStateIndex]["id"] as? Int    //////////////////
        
        func getAddressFromPostalCode(success: @escaping ([String: Any]?) -> (), failure: @escaping (Error?) -> ()) {
            let url = "https://d9001e47-df90-47f2-9b30-3c05628731e6.mock.pstmn.io/addresses"
            var urlComponents = URLComponents(string: url)!
            urlComponents.queryItems = [URLQueryItem(name: "postalcode", value: self.postalCode)]
            let urlRequest = URLRequest(url: urlComponents.url!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,                              // is there data
                      let response = response as? HTTPURLResponse,  // is there HTTP response
                      200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                      error == nil else { failure(error); return }
                
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
                success(responseObject)
            }
            task.resume()
        }
        
        getAddressFromPostalCode(success: { responseDic in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.shadowView.isHidden = true
            }
            
            if let address = responseDic {
                let state = address["state"] as! String
                let city = address["city"] as! String
                
                let stateAlreadyPicked = self.states[self.currentStateIndex]["name"] as! String
                let cityAlreadyPicked = self.cities[self.currentCityIndex]["name"] as! String
                
                let statesEqual = state.compare(stateAlreadyPicked, options: .literal) == .orderedSame
                let citiesEqual = city.compare(cityAlreadyPicked, options: .literal) == .orderedSame
                if statesEqual && citiesEqual {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "postalAddressToPasswordSegue", sender: nil)
                    }
                } else if statesEqual && !citiesEqual {
                    DispatchQueue.main.async {
                        self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "شهر انتخابی با کدپستی هم‌خوانی ندارد.")
                    }
                } else if !statesEqual {
                    DispatchQueue.main.async {
                        self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "استان انتخابی با کدپستی هم‌خوانی ندارد.")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "برای کدپستی مورد نظر آدرسی یافت نشد.")
                }
            }
            
            
        }, failure: { error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.shadowView.isHidden = true
                self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: error?.localizedDescription ?? "خطای غیرمنتظره")
            }
        })
        

    }
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var confrimButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBAction func confrimButtonPressed(_ sender: UIButton) {
        let row = self.pickerView.selectedRow(inComponent: 0)
        switch self.pickingStatus {
        case .states:
            if self.currentCityIndex != -1 && self.currentStateIndex != row {
                self.currentCityIndex = -1
                self.cityNameLabel.text = "نام شهر"
            }
            
            if self.currentStateIndex != row {
                self.currentStateIndex = row
                self.stateNameLabel.text = self.states[self.currentStateIndex]["name"] as? String
            }
        case .cities:
            self.currentCityIndex = row
            self.cityNameLabel.text = self.cities[self.currentCityIndex]["name"] as? String
        case .none:
            break
        }

        self.pickingStatus = .none
        pickerView.isHidden = true
        self.shadowView.isHidden = true
        self.confrimButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickStateButton.layer.cornerRadius = 10
        self.pickCityButton.layer.cornerRadius = 10
        
        self.postalCodeTextField.delegate = self
        
        self.stateNameLabel.layer.cornerRadius = 10
        self.stateNameLabel.layer.borderWidth = 1
        self.stateNameLabel.layer.borderColor = CGColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.stateNameLabel.clipsToBounds = true
        
        self.cityNameLabel.layer.cornerRadius = 10
        self.cityNameLabel.layer.borderWidth = 1
        self.cityNameLabel.layer.borderColor = CGColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.cityNameLabel.clipsToBounds = true
        
        self.postalCodeTextField.layer.cornerRadius = 20
        self.postalCodeTextField.layer.borderWidth = 2
        self.postalCodeTextField.layer.borderColor = CGColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.postalCodeTextField.clipsToBounds = true
        
        self.postalCodeValidLabel.isHidden = true
        
        self.nextButton.layer.cornerRadius = 20
        
        self.shadowView.isHidden = true
        
        self.confrimButton.isHidden = true
        
        self.confrimButton.layer.cornerRadius = 10
        
        self.pickerView.isHidden = true
        
        self.pickerView.layer.cornerRadius = 30
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
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

extension SetPostalAddressViewController: UITextFieldDelegate {
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

extension SetPostalAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.pickingStatus {
        case .states:
            return self.states.count
        case .cities:
            return self.cities.count
        case .none:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.pickingStatus {
        case .states:
            return self.states[row]["name"] as? String
        case .cities:
            return self.cities[row]["name"] as? String
        case .none:
            return nil
        }
    }
}
