//
//  CheckBoxView.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

final class CheckboxStackView: UIStackView {
    
    private let checkbox = UIButton(type: .custom)
    private let textLabel = UILabel()
    
    var isChecked: Bool {
        get {
            return checkbox.isSelected
        }
        set {
            checkbox.isSelected = newValue
        }
    }
    
    init(labelText: String) {
        super.init(frame: .zero)
        commonInit(labelText: labelText)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(labelText: "")
    }
    
    private func commonInit(labelText: String) {
        checkbox.setImage(UIImage(systemName: "checkmark.square")?.withTintColor(.black, renderingMode: .alwaysTemplate), for: .selected)
        checkbox.setImage(UIImage(systemName: "square")?.withRenderingMode(.alwaysTemplate).withTintColor(.black), for: .normal)
        
        textLabel.font = UIFont(name: Assets.Font.degularSemibold, size: 18)
        textLabel.numberOfLines = 0
        textLabel.text = labelText
        
        addArrangedSubview(checkbox)
        addArrangedSubview(textLabel)
        
        axis = .horizontal
        spacing = 10
        alignment = .center
    }
    
    func setCheckboxEnabled(_ enabled: Bool) {
        checkbox.isEnabled = enabled
    }
}
