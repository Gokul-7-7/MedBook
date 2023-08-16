//
//  LandingPageViews.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

class LandingPageViews {
    
    lazy var landingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.Images.landingImage)
        return imageView
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.Font.degularBold, size: 22)
        button.backgroundColor = Constant.Colors.buttonBackground
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.Font.degularBold, size: 22)
        button.backgroundColor = Constant.Colors.buttonBackground
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
}
