//
//  LoginPageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import CoreData
import CryptoKit

final class LoginPageViewController: UIViewController {
    
    private let loginPageViews = LoginPageViews()
    var viewModel: LoginPageViewModelProtocol
    
    // MARK: - Initialiser
    init(viewModel: LoginPageViewModelProtocol = LoginViewModelImpl()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Button actions
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginButtonPressed() {
        guard let email = viewModel.email, let password = viewModel.password else {
            self.showToast(message: Copies.LoginCopies.enterUserNamePassword)
            return
        }
        viewModel.login(email: email, password: password) { [weak self] loginStatus in
            guard let self else { return }
            switch loginStatus {
            case .success:
                self.viewModel.saveAuthToken() { result in
                    switch result {
                    case .success:
                        let homePageVC = HomePageViewController()
                        self.navigationController?.pushViewController(homePageVC, animated: true)
                    case .error(_):
                        self.showToast(message: "Error while logging in")
                    default:
                        break
                    }
                }
            case .passwordMismatch:
                self.showToast(message: Copies.LoginCopies.passwordIncorrect)
                self.loginPageViews.passwordTextField.text = ""
            case .userNotFound:
                self.showToast(message: Copies.LoginCopies.userNotFound)
                self.loginPageViews.emailTextField.text = ""
                self.loginPageViews.passwordTextField.text = ""
            case .noHashPasswordAttribute:
                self.showToast(message: Copies.LoginCopies.passwordCantBeFound)
            case .passwordHashFail:
                self.showToast(message: Copies.LoginCopies.passwordHashFail)
            case .error(let error):
                self.loginPageViews.emailTextField.text = ""
                self.loginPageViews.passwordTextField.text = ""
                self.showToast(message: "Can't login: \(error)")
            }
        }
    }
}

private extension LoginPageViewController {
    
    func setupUI() {
        view = BackgroundView().customBackgroundWithShape
        setupNavigation()
        setupConstraints()
        loginPageViews.emailTextField.delegate = self
        loginPageViews.passwordTextField.delegate = self
    }
    
    func setupNavigation() {
        title = Copies.NavigationTitle.welcomeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        let backButton = UIButton(type: .system)
        backButton.setTitle("", for: .normal) // No text
        backButton.setImage(UIImage(systemName: Assets.Images.leftArrow), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.sizeToFit()
        let customBackButtonItem = UIBarButtonItem(customView: backButton)
        
        // Set the custom button as the left bar button item
        navigationItem.leftBarButtonItem = customBackButtonItem
    }
    
    // MARK: - Constraints setup methods
    func setupConstraints() {
        setupPageTitleConstraints()
        setupEmailTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupLoginButtonConstraints()
    }
    
    func setupPageTitleConstraints() {
        view.addSubview(loginPageViews.simulatedLargeTitleLabel)
        loginPageViews.simulatedLargeTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 35, enableInsets: false)
    }
    
    func setupEmailTextFieldConstraints() {
        view.addSubview(loginPageViews.emailTextField)
        loginPageViews.emailTextField.anchor(top: loginPageViews.simulatedLargeTitleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 70, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 40, enableInsets: false)
    }
    
    func setupPasswordTextFieldConstraints() {
        view.addSubview(loginPageViews.passwordTextField)
        loginPageViews.passwordTextField.anchor(top: loginPageViews.emailTextField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 60, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: nil, height: 40, enableInsets: false)
    }
    
    func setupLoginButtonConstraints() {
        loginPageViews.loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginPageViews.loginButton)
        loginPageViews.loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        loginPageViews.loginButton.topAnchor.constraint(greaterThanOrEqualTo: loginPageViews.passwordTextField.bottomAnchor, constant: 8).isActive = true
        loginPageViews.loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginPageViews.loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginPageViews.loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginPageViews.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
}
