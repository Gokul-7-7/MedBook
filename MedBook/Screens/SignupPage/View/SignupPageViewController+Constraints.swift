//
//  SignupPageViewController+Constraints.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension SignupPageViewController {
   
    func setupUI() {
        view = customBackgroundView
        setupNavigation()
        setupConstraints()
    }
    
    func setupNavigation() {
        title = NavigationTitle.welcomeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("", for: .normal) // No text
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.sizeToFit()
        let customBackButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = customBackButtonItem
    }
    
    func setupConstraints() {
        setupPageTitleConstraints()
        setupEmailTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupCharCountConstraints()
        setupUppercaseCheckBoxViewConstraints()
        setupSpecialCharCheckBoxViewConstraints()
        setupCountryPickerViewConstraints()
        setupProceedButtonConstraints()
    }
    
    func setupPageTitleConstraints() {
        view.addSubview(signupPageViews.simulatedLargeTitleLabel)
        signupPageViews.simulatedLargeTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 35, enableInsets: false)
    }
    
    func setupEmailTextFieldConstraints() {
        view.addSubview(signupPageViews.emailTextField)
        signupPageViews.emailTextField.anchor(top: signupPageViews.simulatedLargeTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 20, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 40, enableInsets: false)
    }
    
    func setupPasswordTextFieldConstraints() {
        view.addSubview(signupPageViews.passwordTextField)
        signupPageViews.passwordTextField.anchor(top: signupPageViews.emailTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 40, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 40, enableInsets: false)
    }
    
    func setupCharCountConstraints() {
        view.addSubview(charCountCheckBoxView)
        
        charCountCheckBoxView.anchor(top: signupPageViews.passwordTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 60, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 30, enableInsets: false)
    }
    
    func setupUppercaseCheckBoxViewConstraints() {
        view.addSubview(uppercaseCheckBoxView)
        
        uppercaseCheckBoxView.anchor(top: charCountCheckBoxView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 5, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 30, enableInsets: false)
    }
    
    func setupSpecialCharCheckBoxViewConstraints() {
        view.addSubview(specialCharCheckBoxView)
        
        specialCharCheckBoxView.anchor(top: uppercaseCheckBoxView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 5, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 30, enableInsets: false)
    }
    
    func setupCountryPickerViewConstraints() {
        view.addSubview(signupPageViews.countryPickerView)
        signupPageViews.countryPickerView.anchor(top: specialCharCheckBoxView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 60, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 140, enableInsets: false)
    }
    
    // MARK: - Activity Indicator
    func setupActivityIndicatorConstraints() {
        signupPageViews.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupPageViews.activityIndicator)
        signupPageViews.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupPageViews.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupProceedButtonConstraints() {
        signupPageViews.letsGoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupPageViews.letsGoButton)
        signupPageViews.letsGoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        signupPageViews.letsGoButton.topAnchor.constraint(greaterThanOrEqualTo: signupPageViews.countryPickerView.bottomAnchor, constant: 8).isActive = true
        signupPageViews.letsGoButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signupPageViews.letsGoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        signupPageViews.letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupPageViews.letsGoButton.addTarget(self, action: #selector(letsGoButtonTapped), for: .touchUpInside)
    }
}
