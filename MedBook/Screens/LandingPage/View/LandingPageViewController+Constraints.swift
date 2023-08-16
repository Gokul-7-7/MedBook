//
//  LandingPageViewController+Constraints.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension LandingPageViewController {
    
    func configuration() {
        setupUI()
        setupConstraints()
        //setupNavigationBar()
        setupButtonActions()
    }
    
    func setupUI() {
        view = customBackgroundView
        title = Constant.NavigationTitle.landingPageTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        setupConstraints()
    }
    
//    func setupNavigationBar() {
//        let customFont = UIFont(name: "Degular-Bold", size: 32) // Change to your custom font name and size
//        let textAttributes = [NSAttributedString.Key.font: customFont]
//
//        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
//    }
    
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
        
        // Add buttons to the stack view
        landingPageViews.buttonStackView.addArrangedSubview(landingPageViews.signupButton)
        landingPageViews.buttonStackView.addArrangedSubview(landingPageViews.loginButton)
       
        landingPageViews.buttonStackView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 28, paddingBottom: 24, paddingRight: 28, width: nil, height: 60, enableInsets: false)
        landingPageViews.buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
