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
        themeManager.register(observer: self)
    }
    

    
    
}

extension NavController: Themeable {
    func apply(theme: Theme) {

    }
}
