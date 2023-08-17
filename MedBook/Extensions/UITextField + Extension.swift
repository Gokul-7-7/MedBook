//
//  UITextField + Extension.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension UITextField {
    
    var withDoneButton: UITextField {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        doneToolbar.items = [flexSpace, doneButton]
        
        inputAccessoryView = doneToolbar
        
        return self
    }
    
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
}




