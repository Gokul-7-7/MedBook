//
//  SignupPageViewController+PickerViewDelegate.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension SignupPageViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countryList?[row].country
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = viewModel.countryList?[row].country
    }
}
