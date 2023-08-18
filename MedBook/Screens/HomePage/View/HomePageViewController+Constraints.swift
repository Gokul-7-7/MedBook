//
//  HomePageViewController+Constraints.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension HomePageViewController {
    
    func setupUI() {
        setupNavigation()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupNavigation() {
        title = NavigationTitle.medBookTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
    }
    // MARK: - Constraints setup methods
    func setupConstraints() {
        setupLogutButtonConstraints()
        setupHeaderConstraints()
    }
    
    func setupHeaderConstraints() {
        view.addSubview(headerLabel)
        headerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: nil, height: nil, enableInsets: false)
    }
    
    func setupLogutButtonConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
}
