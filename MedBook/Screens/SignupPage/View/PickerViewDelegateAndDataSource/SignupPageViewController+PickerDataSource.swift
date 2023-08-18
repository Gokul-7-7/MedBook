//
//  SignupPageViewController+PickerDataSource.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension SignupPageViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countryList?.count ?? 0
    }
}

