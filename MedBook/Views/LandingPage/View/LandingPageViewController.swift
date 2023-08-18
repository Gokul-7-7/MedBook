//
//  LandingPageViewController.swift
//  MedBook
//
//  Created by Gokul on 16/08/23.
//

import UIKit

final class LandingPageViewController: UIViewController {
    
    let landingPageViews = LandingPageViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

private extension LandingPageViewController {
    
    func configuration() {
        setupUI()
        setupButtonActions()
        setupConstraints()
    }
    
    func setupUI() {
        view = BackgroundView().customBackgroundWithShape
        title = Copies.NavigationTitle.medBookTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setupConstraints()
    }
    
    func setupConstraints() {
        setupImageConstraints()
        setupStackViewConstraints()
        setupButtonConstraints()
    }
    
    func setupImageConstraints() {
        view.addSubview(landingPageViews.landingImageView)
        landingPageViews.landingImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nil, height: 400, enableInsets: false)
    }
    
    func setupButtonConstraints() {
        landingPageViews.signupButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        landingPageViews.loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        landingPageViews.signupButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        landingPageViews.loginButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setupStackViewConstraints() {
        view.addSubview(landingPageViews.buttonStackView)
        
        landingPageViews.buttonStackView.addArrangedSubview(landingPageViews.signupButton)
        landingPageViews.buttonStackView.addArrangedSubview(landingPageViews.loginButton)
        
        landingPageViews.buttonStackView.anchor(top: landingPageViews.landingImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 200, paddingLeft: 28, paddingBottom: 24, paddingRight: 28, width: nil, height: 60, enableInsets: false)
        landingPageViews.buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

private extension LandingPageViewController {
    
    func setupButtonActions() {
        landingPageViews.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        landingPageViews.signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let coreDataManager = CoreDataManager()
        let loginPageVC = LoginPageViewController()
        self.navigationController?.pushViewController(loginPageVC, animated: true)
    }
    
    @objc func signupButtonTapped() {
        let viewModel = SignupPageViewModelImpl()
        let signupPageVC = SignupPageViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(signupPageVC, animated: true)
    }
}
