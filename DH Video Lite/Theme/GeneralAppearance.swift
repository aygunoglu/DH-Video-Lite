//
//  GeneralAppearance.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 28.09.2021.
//

import UIKit

class GeneralAppearance: NSObject {
    
    class func setupAppearance(theme: Theme = ThemeManager.shared.theme) {
        let attributes = [NSAttributedString.Key.foregroundColor: theme.orangeUI]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)

        if #available(iOS 13.0, *) {
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = navigationbarAppearance()
            UINavigationBar.appearance().compactAppearance = navigationbarAppearance()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationbarAppearance()
            
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
        
//        UINavigationBar.appearance().barTintColor = theme.navigationbarColor
//        UINavigationBar.appearance().tintColor = theme.orangeUI
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: theme.textColor]
//        UINavigationBar.appearance().prefersLargeTitles = false
//
//        UITableView.appearance().tintColor = theme.orangeUI
//        UISwitch.appearance().onTintColor = theme.orangeUI
        
    }
    
    @available(iOS 13.0, *)
    class func navigationbarAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = ThemeManager.shared.theme.navigationbarColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: ThemeManager.shared.theme.textColor]
        return navBarAppearance
    }
    
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}

//extension UINavigationController {
//    override open var preferredStatusBarStyle: UIStatusBarStyle {
//        return ThemeManager.shared.theme.statusBarStyle
//    }
//
//    override open var childForStatusBarStyle: UIViewController? {
//        return self.topViewController
//    }
//}
