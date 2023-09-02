//
//  AssetConstants.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit

struct Assets {
    
    struct API {
        static let countryApi = "https://api.first.org/data/v1/countries"
        static let listApi = "https://openlibrary.org/search.json"
    }
    
    struct Font {
        static let degularRegular = "Degular-Regular"
        static let degularMedium = "Degular-Medium"
        static let degularSemibold = "Degular-semibold"
        static let degularBold = "Degular-Bold"
    }
    
    struct Images {
        static let landingImage = "landingImage"
        static let curveShape = "shape-curve"
        static let rightArrow = "arrow.right.circle"
        static let checkedBox = "checkedBox"
        static let uncheckedBox = "uncheckedBox"
        static let leftArrow = "chevron.left"
    }
    
    enum Colors {
        static let backgroundColorWhite = UIColor(named: "backgroundColorOne")
        static let backgroundColorBlack = UIColor(named: "backgroundColorTwo")
        static let buttonBackground = UIColor(named: "buttonBackgroundColor")
    }
}
