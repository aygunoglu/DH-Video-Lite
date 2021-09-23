//
//  NavController.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 21.09.2021.
//

import UIKit
import SwiftTheme

class NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        
        
    }
    
    func setNavBar( ) {
        self.navigationBar.prefersLargeTitles = false
        self.isNavigationBarHidden = false
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.red
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
}

