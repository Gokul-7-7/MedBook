//
//  LandingPageViewController+ButtonActions.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

extension LandingPageViewController {
    
    func setupButtonActions() {
        landingPageViews.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        landingPageViews.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        print("Login button pressed")
    }
    
    @objc func signupButtonTapped() {
        print("Sign up button pressed")
    }
    
}
