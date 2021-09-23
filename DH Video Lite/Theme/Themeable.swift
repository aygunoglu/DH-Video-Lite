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

extension Themeable {
    var themeManager: ThemeManageable {
        return ThemeManager.shared
    }
}
