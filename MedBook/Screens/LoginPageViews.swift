//
//  LoginPageViews.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

class LoginPageViews {
    
    lazy var simulatedLargeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "log in to continue"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .gray
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "Email"
        textField.font = UIFont(name: Font.degularMedium, size: 18)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        let bottomLine = UIView()
        bottomLine.backgroundColor = .gray
        textField.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: textField.leadingAnchor, bottom: textField.bottomAnchor, trailing: textField.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: nil, height: 1.5, enableInsets: false)
        textField.tag = TextFieldTags.emailTextField.rawValue
        return textField.withDoneButton
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "Password"
        textField.font = UIFont(name: Font.degularMedium, size: 18)
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.passwordRules = .none
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        let bottomLine = UIView()
        bottomLine.backgroundColor = .gray
        textField.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: textField.leadingAnchor, bottom: textField.bottomAnchor, trailing: textField.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: nil, height: 1.5, enableInsets: false)
        textField.tag = TextFieldTags.passwordTextField.rawValue
        return textField.withDoneButton
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login ", for: .normal)
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = UIFont(name: Font.degularBold, size: 22)
        button.backgroundColor = Colors.buttonBackground
        button.setTitleColor(.gray, for: .normal)
        //button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.gray), for: .normal)
        let image = UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        button.setImage(image?.withTintColor(.black, renderingMode: .alwaysTemplate), for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.isEnabled = true
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
}
