//
//  BackgroundView.swift
//  MedBook
//
//  Created by Gokul on 16/08/23.
//

import UIKit

class BackgroundView {
    
    lazy var customBackgroundWithShape: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let backgroundImage = UIImageView(image: UIImage(named: Constant.Images.curveShape))
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.clipsToBounds = true
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nil, height: 400, enableInsets: false)
        return view
    }()
    
}
