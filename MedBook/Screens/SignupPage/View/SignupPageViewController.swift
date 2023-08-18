//
//  SignupPageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import CryptoKit

class SignupPageViewController: UIViewController {
    
    let customBackgroundView = BackgroundView().customBackgroundWithShape
    let signupPageViews = SignupPageViews()
    lazy var charCountCheckBoxView = CheckboxStackView(labelText: "Char count")
    lazy var uppercaseCheckBoxView = CheckboxStackView(labelText: "Uppercase")
    lazy var specialCharCheckBoxView = CheckboxStackView(labelText: "special char")
    
    let coreDataManager = CoreDataManager()
    let viewModel: SignupPageViewModelProtocol
    
    var selectedCountry: String?
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    var email: String?
    var password: String?
    
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
        guard let username = email, !username.isEmpty,
              let password = password, !password.isEmpty else {
            return
        }
        coreDataManager.saveUser(email: username, password: password) { userSaved in
            if userSaved {
                self.saveAuthToken()
                self.showToast(message: "Signup successful")
            } else {
                self.showToast(message: "Signup failed, try again!")
            }
        }
    }
    
    // MARK: - Save authentication token method
    private func saveAuthToken() {
        let authToken = AuthTokenManager.generateRandomToken()
        
        // Save the auth token securely in the Keychain
        if AuthTokenManager.saveAuthToken(authToken) {
            let homePageVC = HomePageViewController()
            self.navigationController?.pushViewController(homePageVC, animated: true)
            print("Auth token saved successfully after signup")
        } else {
            self.navigationController?.popViewController(animated: true)
            self.showToast(message: "Error! Try logging in")
            print("Failed to save auth token after signup")
        }
    }
}

