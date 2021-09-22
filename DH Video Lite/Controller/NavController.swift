//
//  NavController.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 21.09.2021.
//

import UIKit

class NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.barTintColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 255/255)
        self.isNavigationBarHidden = false
        
    }
    
}

