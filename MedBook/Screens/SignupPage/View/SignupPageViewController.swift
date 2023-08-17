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
    let charCountCheckBoxView = CheckboxStackView(labelText: "Char count")
    let uppercaseCheckBoxView = CheckboxStackView(labelText: "Uppercase")
    let specialCharCheckBoxView = CheckboxStackView(labelText: "special char")
    let coreDataManager = CoreDataManager()

    
    let viewModel: SignupPageViewModelProtocol
    
    var selectedCountry: String?
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    var email: String?
    var password: String?
    
    
    init(viewModel: SignupPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
    
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
                self.showToast(message: "Signup successful")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showToast(message: "Signup failed, try again!")
            }
        }
    }
}
    
