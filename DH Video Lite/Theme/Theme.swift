//
//  Theme.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 19.09.2021.
//

import UIKit

struct Theme: Equatable {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)

    enum `Type` {
        case light
        case dark
    }
    let type: Type
    let background: UIColor
    let textColor: UIColor
    let separatorColor: UIColor
    let portalCellBackground: UIColor
    let navigationbarColor: UIColor
    let navbarStyle: UIBarStyle
    let navbarTitleAttrs: [NSAttributedString.Key : Any]
    let switchTintColor: UIColor
    let orangeUI: UIColor
    let statusBarStyle: UIStatusBarStyle

    init(type: Type, colors: ColorPalette) {
        self.type = type
        self.background = colors.background
        self.textColor = colors.textColor
        self.separatorColor = colors.seperatorColor
        self.portalCellBackground = colors.portalCellBackground
        self.navbarStyle = colors.navbarStyle
        self.navigationbarColor = colors.navigationbarColor
        self.switchTintColor = colors.switchTintColor
        self.navbarTitleAttrs = type == .dark ? [NSAttributedString.Key.foregroundColor: UIColor.white] : [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.orangeUI = colors.orangeUI
        self.statusBarStyle = colors.statusBarStyle
        
    }

    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.type == rhs.type
    }
}

extension UIStatusBarStyle {
    static var autoDarkContent: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}
