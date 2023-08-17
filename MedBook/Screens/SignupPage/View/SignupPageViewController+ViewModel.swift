//
//  SignupPageViewController+ViewModel.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation


extension SignupPageViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
        setupPickerView()
        setupUI()
    }
    
    func initViewModel() {
        viewModel.onViewDidLoad()
    }
    
    func setupPickerView() {
        signupPageViews.emailTextField.delegate = self
        signupPageViews.passwordTextField.delegate = self
        signupPageViews.countryPickerView.dataSource = self
        signupPageViews.countryPickerView.delegate = self
    }
    
    ///This will observe event of Data binding - communication
    func observeEvent() {
        //capture list
        viewModel.eventHandler = { [weak self]event in
            guard let self else { return }
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.signupPageViews.activityIndicator.startAnimating()
                    self.signupPageViews.countryPickerView.isHidden = true
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.signupPageViews.activityIndicator.stopAnimating()
                    self.signupPageViews.countryPickerView.isHidden = false
                }
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.signupPageViews.activityIndicator.stopAnimating()
                    self.reloadInputViews()
                    self.signupPageViews.countryPickerView.reloadAllComponents()
                    ///The first country of picker is selected by default
                    self.selectedCountry = self.viewModel.countryList?.first?.country
                }
            case .error(let error):
                print(error ?? "Error in calling the country list api")
            }
        }
    }
}
