//
//  LandingPageViewController.swift
//  MedBook
//
//  Created by Gokul on 16/08/23.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    let customBackgroundView = BackgroundView().customBackgroundWithShape
    let landingPageViews = LandingPageViews()
    
    let viewModel = LandingPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}
