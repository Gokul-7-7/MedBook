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
    //Is this correct?
    @objc func loginButtonTapped() {
        let coreDataManager = CoreDataManager()
        let loginPageVC = LoginPageViewController(viewModel: LoginViewModelImpl(coreDataManager: coreDataManager))
        self.navigationController?.pushViewController(loginPageVC, animated: true)
    }
    
    @objc func signupButtonTapped() {
        let viewModel = SignupPageViewModelImpl(coreDataManager: CoreDataManager())
        let signupPageVC = SignupPageViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(signupPageVC, animated: true)
    }
    
}
