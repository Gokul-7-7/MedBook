//
//  SignupPageViews.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

final class SignupPageViews {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    lazy var simulatedLargeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to continue"
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
        bottomLine.anchor(top: nil, leading: textField.leadingAnchor, bottom: textField.bottomAnchor, trailing: textField.trailingAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: nil, height: 1.5, enableInsets: false)
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
        textField.textContentType = .oneTimeCode
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        let bottomLine = UIView()
        bottomLine.backgroundColor = .gray
        textField.addSubview(bottomLine)
        bottomLine.anchor(top: nil, leading: textField.leadingAnchor, bottom: textField.bottomAnchor, trailing: textField.trailingAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: -5, paddingRight: 0, width: nil, height: 1.5, enableInsets: false)
        textField.tag = TextFieldTags.passwordTextField.rawValue
        return textField.withDoneButton
    }()
    
    lazy var countryPickerView : UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var letsGoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's go ", for: .normal)
        button.titleLabel?.textColor = .gray
        button.titleLabel?.font = UIFont(name: Font.degularBold, size: 22)
        button.backgroundColor = Colors.buttonBackground
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "arrow.right")?.withTintColor(.gray), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.isEnabled = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var characterCountCheckView: UIStackView = {
        let stackView = UIStackView()
        let checkBoxView = UIImageView()
        let label = UILabel()
        checkBoxView.image = UIImage(named: Images.uncheckedBox)
        checkBoxView.contentMode = .scaleAspectFit
        checkBoxView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        checkBoxView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        
        label.text = "At least 8 characters"
        label.font = UIFont(name: Font.degularSemibold, size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(checkBoxView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }()
    
    lazy var uppercaseCheckView: UIStackView = {
        let stackView = UIStackView()
        let checkBoxView = UIImageView()
        let label = UILabel()
        checkBoxView.image = UIImage(named: Images.uncheckedBox)
        checkBoxView.contentMode = .scaleAspectFit
        checkBoxView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        checkBoxView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        
        label.text = "Must contain an uppercase letter"
        label.font = UIFont(name: Font.degularSemibold, size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(checkBoxView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }()
    
    lazy var specialCharCheckView: UIStackView = {
        let stackView = UIStackView()
        let checkBoxView = UIImageView()
        let label = UILabel()
        checkBoxView.image = UIImage(named: Images.uncheckedBox)
        checkBoxView.contentMode = .scaleAspectFit
        checkBoxView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        checkBoxView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        
        label.text = "Contains a special character"
        label.font = UIFont(name: Font.degularSemibold, size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(checkBoxView)
        stackView.addArrangedSubview(label)
        
        return stackView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(characterCountCheckView)
        stackView.addArrangedSubview(uppercaseCheckView)
        stackView.addArrangedSubview(specialCharCheckView)
        
        return stackView
    }()
    
}
