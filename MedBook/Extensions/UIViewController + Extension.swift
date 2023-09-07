//
//  UIViewController + Extension.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

extension UIViewController {
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.font = UIFont(name: Assets.Font.degularSemibold, size: 18)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(toastLabel)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let leadingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1, constant: 16)
            let trailingConstraint = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1, constant: -16)
            let bottomConstraint = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: window.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -100)
            
            NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint])
            
            UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
