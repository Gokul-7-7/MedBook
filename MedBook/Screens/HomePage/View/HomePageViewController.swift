//
//  HomePageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import Security

class HomePageViewController: UIViewController {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.degularMedium, size: 32)
        label.numberOfLines = 2
        label.text = "Which topic interests you today?"
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont(name: Font.degularMedium, size: 22)
        button.setTitleColor(.red, for: .normal)
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
    func replaceRootViewController() {
        // Create a new instance of the view controller you want to set as root
        let newRootViewController: UIViewController = UINavigationController(rootViewController: LandingPageViewController())
        // Replace with your actual view controller class
        
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
