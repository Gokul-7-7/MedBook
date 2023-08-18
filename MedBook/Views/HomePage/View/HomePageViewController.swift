//
//  HomePageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import Security

final class HomePageViewController: UIViewController {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularMedium, size: 32)
        label.numberOfLines = 2
        label.text = "Which topic interests you today?"
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont(name: Assets.Font.degularMedium, size: 22)
        button.setTitleColor(.systemRed, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Logout button action
    @objc func logoutButtonTapped() {
        if AuthTokenManager.removeAuthToken() {
            print("Auth token removed successfully")
            replaceRootViewController()
        } else {
            print("Failed to remove auth token")
            self.showToast(message: "Error while logging out")
        }
    }
    
    // MARK: - Methods
    private func replaceRootViewController() {
        // Create a new instance of the view controller you want to set as root
        let newRootViewController: UIViewController = UINavigationController(rootViewController: LandingPageViewController())
        // Access the SceneDelegate
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            // Replace the root view controller of the scene's window
            if let window = sceneDelegate.window {
                window.rootViewController = newRootViewController
            }
        }
        self.showToast(message: "Logged Out Successfully")
    }
}

private extension HomePageViewController {
    
    func setupUI() {
        setupNavigation()
        view.backgroundColor = UIColor(hex: "FAFAFA")
        setupConstraints()
    }
    
    func setupNavigation() {
        title = Copies.NavigationTitle.medBookTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Constraints setup methods
    func setupConstraints() {
        setupLogutButtonConstraints()
        setupHeaderConstraints()
    }
    
    func setupHeaderConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
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
