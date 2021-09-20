//
//  NavController.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 19.09.2021.
//

import UIKit

class NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.barTintColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 255/255)
        self.isNavigationBarHidden = false
        themeManager.register(observer: self)
    }
    
}

extension NavController: Themeable {
    func apply(theme: Theme) {
        navigationBar.backgroundColor = theme.navbarBarTintColor
        navigationBar.barStyle = theme.navbarStyle
        navigationBar.barTintColor = theme.navbarBarTintColor
        navigationBar.tintColor = theme.navbarTintColor
        navigationBar.titleTextAttributes = theme.navbarTitleAttrs
    }

}


