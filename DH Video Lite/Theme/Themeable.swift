//
//  Themeable.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 19.09.2021.
//

import UIKit

protocol Themeable: AnyObject {
    func apply(theme: Theme)
}

extension Themeable where Self: AnyObject {
    var themeManager: ThemeManageable {
        return ThemeManager.shared
    }
}
