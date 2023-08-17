//
//  LoginPageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import CoreData
import CryptoKit

class LoginPageViewController: UIViewController {
    
    let customBackgroundView = BackgroundView().customBackgroundWithShape
    let loginPageViews = LoginPageViews()
    let coreDataManager = CoreDataManager()
    
    var email: String?
    var password: String?
    
    var viewModel: LoginPageViewModelProtocol
    
    init(viewModel: LoginPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModelImpl(coreDataManager: coreDataManager)
        setupUI()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func saveAuthToken() {
        let authToken = AuthTokenManager.generateRandomToken()
        
        // Save the auth token securely in the Keychain
        if AuthTokenManager.saveAuthToken(authToken) {
            print("Auth token saved successfully")
        } else {
            print("Failed to save auth token")
        }
    }
    
    @objc func loginButtonPressed() {
        guard let email = viewModel.email, let password = viewModel.password else {
            self.showToast(message: "Enter username and password")
            return
        }
        saveAuthToken()
        viewModel.login(email: email, password: password) { loginStatus in
            switch loginStatus {
            case .success:
                let homePageVC = HomePageViewController()
                self.navigationController?.pushViewController(homePageVC, animated: true)
            case .passwordMismatch:
                self.showToast(message: "Password is incorrect")
                self.loginPageViews.passwordTextField.text = ""
            case .userNotFound:
                self.showToast(message: "User not found")
                self.loginPageViews.emailTextField.text = ""
                self.loginPageViews.passwordTextField.text = ""
            case .noHashPasswordAttribute:
                self.showToast(message: "Password can't be found")
            case .passwordHashFail:
                self.showToast(message: "Error while securely storing password")
            case .error(let error):
                self.loginPageViews.emailTextField.text = ""
                self.loginPageViews.passwordTextField.text = ""
                self.showToast(message: "Can't login: \(error)")
            }
        }
    }
}
