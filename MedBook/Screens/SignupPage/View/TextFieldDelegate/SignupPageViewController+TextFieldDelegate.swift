//
//  SignupPageViewController+TextFieldDelegate.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension SignupPageViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch TextFieldTags(rawValue: textField.tag) {
        case .emailTextField:
            if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                viewModel.updateEmail(updatedText)
                handleButtonVisibility()
            }
            return true
        case .passwordTextField:
            if let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                viewModel.updatePassword(updatedText)
                handlePasswordUIValidation(updatedText)
                handleButtonVisibility()
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
            if viewModel.isValidEmail() {
                email = textField.text
                handleButtonVisibility()
            }
        case .passwordTextField:
            if viewModel.validateCharacterCount(), viewModel.validateUpperCaseLetters(), viewModel.validateSpecialCharacters() {
                password = textField.text
                handleButtonVisibility()
            }
        case .none:
            break
        }
    }
    
    func handleButtonVisibility() {
        if viewModel.isValidEmail(), viewModel.validateCharacterCount(), viewModel.validateUpperCaseLetters(), viewModel.validateSpecialCharacters() {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    // MARK: - Email and password validation helper methods
    func handlePasswordUIValidation(_ text: String?) {
        if viewModel.validateCharacterCount() {
            charCountCheckBoxView.isChecked = true
        } else {
            charCountCheckBoxView.isChecked = false
        }
        if viewModel.validateUpperCaseLetters() {
            uppercaseCheckBoxView.isChecked = true
        } else {
            uppercaseCheckBoxView.isChecked = false
        }
        if viewModel.validateSpecialCharacters() {
            specialCharCheckBoxView.isChecked = true
        } else {
            specialCharCheckBoxView.isChecked = false
        }
        if viewModel.validateCharacterCount(), viewModel.validateUpperCaseLetters(), viewModel.validateSpecialCharacters() {
            password = text
        }
    }
    
    func enableButton() {
        signupPageViews.letsGoButton.isEnabled = true
        signupPageViews.letsGoButton.titleLabel?.alpha = 1
        signupPageViews.letsGoButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    func disableButton() {
        signupPageViews.letsGoButton.isEnabled = false
        signupPageViews.letsGoButton.titleLabel?.alpha = 0.5
        signupPageViews.letsGoButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
}
