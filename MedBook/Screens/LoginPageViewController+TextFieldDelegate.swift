//
//  LoginPageViewController+TextFieldDelegate.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension LoginPageViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch TextFieldTags(rawValue: textField.tag) {
        case .emailTextField:
            if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                viewModel.updateEmail(updatedText)
            }
            return true
        case .passwordTextField:
            if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                viewModel.updatePassword(updatedText)
            }
            return true
        case .none:
            break
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch TextFieldTags(rawValue: textField.tag) {
        case .emailTextField:
            guard let email = textField.text else { return }
            viewModel.updateEmail(email)
        case .passwordTextField:
            guard let password = textField.text else { return }
            viewModel.updatePassword(password)
        case .none:
            break
        }
    }
    
}
