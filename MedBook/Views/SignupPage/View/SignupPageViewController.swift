//
//  SignupPageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import CryptoKit

final class SignupPageViewController: UIViewController {
    
    private let signupPageViews = SignupPageViews()
    private lazy var charCountCheckBoxView = CheckboxStackView(labelText: Copies.SignupCopies.charCount)
    private lazy var uppercaseCheckBoxView = CheckboxStackView(labelText: Copies.SignupCopies.upperCase)
    private lazy var specialCharCheckBoxView = CheckboxStackView(labelText: Copies.SignupCopies.specialChar)
    
    let viewModel: SignupPageViewModelProtocol
    
    var selectedCountry: String?
    
    // MARK: - Initialiser
    init(viewModel: SignupPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    // MARK: - Button actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func letsGoButtonTapped() {
        viewModel.saveUser(email: signupPageViews.emailTextField.text, password: signupPageViews.passwordTextField.text) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                let homePageVC = HomePageViewController()
                self.navigationController?.pushViewController(homePageVC, animated: true)
                self.showToast(message: Copies.SignupCopies.signupSuccess)
            case .failure(_):
                self.navigationController?.popViewController(animated: true)
                self.showToast(message: Copies.SignupCopies.signupError)
            }
        }
    }
}

private extension SignupPageViewController {
    
    func setupUI() {
        view = BackgroundView().customBackgroundWithShape
        setupNavigation()
        setupConstraints()
    }
    
    func setupNavigation() {
        title = Copies.NavigationTitle.welcomeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("", for: .normal) // No text
        backButton.setImage(UIImage(systemName: Assets.Images.leftArrow), for: .normal)
        backButton.tintColor = Assets.Colors.backgroundColorBlack
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.sizeToFit()
        let customBackButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = customBackButtonItem
    }
    
    // MARK: - Constraints setup methods
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

private extension SignupPageViewController {
    
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
            if let email = textField.text, viewModel.isValidEmail() {
                viewModel.updateEmail(email)
                handleButtonVisibility()
            }
        case .passwordTextField:
            if let password = textField.text, viewModel.validateCharacterCount(), viewModel.validateUpperCaseLetters(), viewModel.validateSpecialCharacters() {
                viewModel.updatePassword(password)
                handleButtonVisibility()
            }
        case .none:
            break
        }
    }
    
    private func handleButtonVisibility() {
        if viewModel.isValidEmail(), viewModel.validateCharacterCount(), viewModel.validateUpperCaseLetters(), viewModel.validateSpecialCharacters() {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    // MARK: - Email and password validation helper methods
    private func handlePasswordUIValidation(_ text: String?) {
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
    }
    
    private func enableButton() {
        signupPageViews.letsGoButton.isEnabled = true
        signupPageViews.letsGoButton.titleLabel?.alpha = 1
        signupPageViews.letsGoButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func disableButton() {
        signupPageViews.letsGoButton.isEnabled = false
        signupPageViews.letsGoButton.titleLabel?.alpha = 0.5
        signupPageViews.letsGoButton.layer.borderColor = UIColor.lightGray.cgColor
    }
}
