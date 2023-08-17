//
//  String + Extension.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var hasEightCharacters: Bool {
        // Check for minimum length
        guard self.count >= 8 else {
            return false
        }
        return true
    }
    
    var validateUppercaseLetters: Bool {
        // Check for at least one uppercase character
        let uppercaseLetterSet = CharacterSet.uppercaseLetters
        let uppercaseLetters = self.unicodeScalars.filter { uppercaseLetterSet.contains($0) }
        guard !uppercaseLetters.isEmpty else {
            return false
        }
        return true
    }
    
    var validateSpecialCharacters: Bool {
        // Check for at least one special character
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/[]{}|")
        let specialCharacters = self.unicodeScalars.filter { specialCharacterSet.contains($0) }
        guard !specialCharacters.isEmpty else {
            return false
        }
        
        return true
    }
    
    var hasValidPasswordFormat: Bool {
        // Check for minimum length
        guard self.count >= 8 else {
            return false
        }
        
        // Check for at least one uppercase character
        let uppercaseLetterSet = CharacterSet.uppercaseLetters
        let uppercaseLetters = self.unicodeScalars.filter { uppercaseLetterSet.contains($0) }
        guard !uppercaseLetters.isEmpty else {
            return false
        }
        
        // Check for at least one special character
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/[]{}|")
        let specialCharacters = self.unicodeScalars.filter { specialCharacterSet.contains($0) }
        guard !specialCharacters.isEmpty else {
            return false
        }
        
        return true
    }
    
}
