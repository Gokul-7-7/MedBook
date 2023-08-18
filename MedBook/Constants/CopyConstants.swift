//
//  CopyConstants.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

struct Copies {
    
    struct NavigationTitle {
        static let medBookTitle = "MedBook"
        static let welcomeTitle = "Welcome"
    }
    
    struct SignupCopies {
        static let charCount = "At least 8 characters"
        static let upperCase = "Must contain an uppercase letter"
        static let specialChar = "Contains a special character "
        static let signupSuccess = "Signup successful"
        static let signupError = "Error while signing up, try again!"
    }
    
    struct LoginCopies {
        static let enterUserNamePassword = "Enter username and password"
        static let passwordIncorrect = "Password is incorrect"
        static let userNotFound = "User not found"
        static let passwordCantBeFound = "Password can't be found"
        static let passwordHashFail = "Error while securely storing password"
    }
}
