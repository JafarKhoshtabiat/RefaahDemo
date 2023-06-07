//
//  SetPostalAddressViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/2/23.
//

import UIKit

class PostalAddressViewController: UIViewController {
    private var postalAddressView: PostalAddressViewProtocol = PostalAddressView()
    
    var states: [State]?
    var cities: [City]?
    var currentStateIndex = -1
    var currentCityIndex = -1
    var pickingStatus = PickingStatus.none
    
    var postalCodeIsValid = false
    var postalCode: String?
    
    let postalAddressPickerViewDelegateAndDataSource: PostalAddressPickerViewDelegateAndDataSourceProtocol = PostalAddressPickerViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postalAddressView.flowNextDelegate = self
        self.postalAddressView.textFieldDelegate = self
        self.postalAddressView.textFieldEditingChangedDelegate = self
        self.postalAddressView.postalAddressButtonsTouchUpInsideDelegate = self
        self.postalAddressView.pickerViewDelegateAndDataSource = postalAddressPickerViewDelegateAndDataSource
    }
    
    override func loadView() {
        self.view = self.postalAddressView
    }
}

extension PostalAddressViewController {
    func getStatesAsync() async throws -> Data {
        let urlString = "\(ConfigurationConstants.baseURL)/states"
        guard let url = URL(string: urlString) else { throw MyError.error1 }
        let request = URLRequest(url: url)
        return try await getRequest(request: request)
    }
    
    func getCities(stateId: Int) async throws -> Data {
        let urlString = "\(ConfigurationConstants.baseURL)/cities/\(stateId)"
        guard let url = URL(string: urlString) else { throw MyError.error1 }
        let request = URLRequest(url: url)
        return try await getRequest(request: request)
    }
    
    func getPostalAddress(postalCode: String) async throws -> Data {
        let urlString = "\(ConfigurationConstants.baseURL)/address/\(postalCode)"
        guard let url = URL(string: urlString) else { throw MyError.error1 }
        let request = URLRequest(url: url)
        return try await getRequest(request: request)
    }
    
    func getRequest(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MyError.error1 }
        return data
    }
}

extension PostalAddressViewController: RegistrationFlowNextDelegate {
    func next() {
        Task {
            await self.nextAsync()
        }
    }
}

extension PostalAddressViewController {
    func nextAsync() async {
        guard self.currentStateIndex != -1, let state = self.states?[self.currentStateIndex] else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "لطفا استان محل سکونت خود را انتخاب کنید.")
            return
        }
        
        guard self.currentCityIndex != -1, let city = self.cities?[self.currentCityIndex] else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "لطفا شهر محل سکونت خود را انتخاب کنید.")
            return
        }
        
        guard self.postalCodeIsValid, let postalCode = self.postalCode else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "لطفا کدپستی معتبر وارد کنید.")
            return
        }
        
        self.postalAddressView.showShadowView()
        self.postalAddressView.startAnimatingActivityIndicator()
        
        do {
            let data = try await getPostalAddress(postalCode: postalCode)
            let decodedPostalAddress = try JSONDecoder().decode(PostalAddress.self, from: data)
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.hideShadowView()
            let stateIsEqual = state.name.compare(decodedPostalAddress.stateName, options: .literal) == .orderedSame
            let cityIsEqual = city.name.compare(decodedPostalAddress.cityName, options: .literal) == .orderedSame
            if stateIsEqual && cityIsEqual {
                self.performSegue(withIdentifier: "PostalAddress_to_Password", sender: nil)
            } else if !stateIsEqual {
                self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "استان انتخابی با کدپستی هم‌خوانی ندارد.")
            } else {
                self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "شهر انتخابی با کدپستی هم‌خوانی ندارد.")
            }
        } catch {
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.hideShadowView()
            self.presentUIAlertController(title: "", titleColor: UIColor(named: "Flame Hawkfish")!, message: "برای کدپستی مورد نظر آدرسی یافت نشد.")
        }
    }
}

extension PostalAddressViewController: UITextFieldDelegate {
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

extension PostalAddressViewController: TextFieldEditingChangedDelegate {
    func editingChanged(_ textField: UITextField) {
        guard let currentText = textField.text else {
            self.postalAddressView.hideValidationLabel()
            return
        }
        
        if currentText.count == 10 {
            self.postalCodeIsValid = true
            self.postalCode = currentText
            self.postalAddressView.showValidationLabel(isValid: true)
            textField.resignFirstResponder()
        } else if currentText.count > 10 {
            self.postalCodeIsValid = false
            self.postalAddressView.showValidationLabel(isValid: false)
        } else {
            self.postalCodeIsValid = false
            self.postalAddressView.hideValidationLabel()
        }
    }
}

extension PostalAddressViewController: PostalAddressButtonsTouchUpInsideDelegate {
    func statesButtonDidTouchUpInside() {
        Task {
            await self.statesButtonDidTouchUpInsideAsync()
        }
    }
    
    func citiesButtonDidTouchUpInside() {
        Task {
            await self.citiesButtonDidTouchUpInsideAsync()
        }
    }
    
    func confirmButtonDidTouchUpInside() {
        let selectedRow = self.postalAddressView.getSelectedRowInPickerView()
        switch self.pickingStatus {
        case .states:
            if self.currentCityIndex != -1 && self.currentStateIndex != selectedRow {
                self.currentCityIndex = -1
                self.postalAddressView.resetCityNameLabel()
            }
            
            if self.currentStateIndex != selectedRow {
                guard let stateName = self.states?[selectedRow].name else { return }
                self.currentStateIndex = selectedRow
                self.postalAddressView.setStateNameLabelTo(stateName: stateName)
            }
        case .cities:
            if self.currentCityIndex != selectedRow {
                guard let cityName = self.cities?[selectedRow].name else { return }
                self.currentCityIndex = selectedRow
                self.postalAddressView.setCityNameLabelTo(cityName: cityName)
            }
        case .none:
            break
        }
        
        self.pickingStatus = .none
        self.postalAddressPickerViewDelegateAndDataSource.setPickingStatus(status: .none)
        self.postalAddressView.hidePickerView()
        self.postalAddressView.hideConfirmButton()
        self.postalAddressView.hideShadowView()
    }
}

extension PostalAddressViewController {
    func statesButtonDidTouchUpInsideAsync() async {
        self.postalAddressView.showShadowView()
        self.postalAddressView.startAnimatingActivityIndicator()
                
        do {
            let data = try await getStatesAsync()
            let decodedStates = try JSONDecoder().decode([State].self, from: data)
            self.states = decodedStates
            self.postalAddressPickerViewDelegateAndDataSource.statesRetrieved(states: decodedStates)
            self.pickingStatus = .states
            self.postalAddressPickerViewDelegateAndDataSource.setPickingStatus(status: .states)
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.reloadPickerView()
            if self.currentStateIndex != -1 {
                self.postalAddressView.selectPickerViewWith(index: self.currentStateIndex)
            } else {
                self.postalAddressView.selectPickerViewWith(index: 0)
            }
            self.postalAddressView.showPickerView()
            self.postalAddressView.showConfirmButton()
        } catch {
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.hideShadowView()
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: error.localizedDescription)
        }
    }
    
    func citiesButtonDidTouchUpInsideAsync() async {
        guard let states = self.states, self.currentStateIndex >= 0 else {
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: "لطفا ابتدا استان را انتخاب کنید.")
            return
        }
        
        self.postalAddressView.showShadowView()
        self.postalAddressView.startAnimatingActivityIndicator()
        let stateId = states[self.currentStateIndex].id
        do {
            let data = try await getCities(stateId: stateId)
            let decodedCities = try JSONDecoder().decode([City].self, from: data)
            self.cities = decodedCities
            self.postalAddressPickerViewDelegateAndDataSource.citiesRetirieved(cities: decodedCities)
            self.pickingStatus = .cities
            self.postalAddressPickerViewDelegateAndDataSource.setPickingStatus(status: .cities)
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.reloadPickerView()
            if self.currentCityIndex != -1 {
                self.postalAddressView.selectPickerViewWith(index: self.currentCityIndex)
            } else {
                self.postalAddressView.selectPickerViewWith(index: 0)
            }
            self.postalAddressView.showPickerView()
            self.postalAddressView.showConfirmButton()
        } catch {
            self.postalAddressView.stopAnimatingActivityIndicator()
            self.postalAddressView.hideShadowView()
            self.presentUIAlertController(title: "", titleColor: UIColor.flameHawkfish, message: error.localizedDescription)
        }
    }
}
