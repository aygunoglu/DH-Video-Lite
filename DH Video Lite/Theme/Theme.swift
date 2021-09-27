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

    let portalListBackgroundColor: UIColor
    let textColor: UIColor
    let descriptionTextColor: UIColor

    let separatorColor: UIColor
    let tableViewCellBackgroundColor: UIColor
    let settingsCellColor: UIColor
    //let portalListCellContainerColor: UIColor

    let navbarTintColor: UIColor
    let navbarStyle: UIBarStyle
    let navbarBarTintColor: UIColor
    let navbarTitleAttrs: [NSAttributedString.Key : Any]

    let switchTintColor: UIColor

    init(type: Type, colors: ColorPalette) {
        self.type = type
        self.portalListBackgroundColor = colors.portalListBackground
        self.textColor = colors.textColor
        self.descriptionTextColor = colors.secondary
        self.separatorColor = colors.secondary
        self.tableViewCellBackgroundColor = colors.tableViewCellBackgroundColor
        self.navbarTintColor = colors.navBarTintColor
        self.navbarStyle = type == .dark ? .black : .default
        self.navbarBarTintColor = colors.navBarBarTintColor
        self.switchTintColor = colors.switchTintColor
        self.settingsCellColor = colors.settingsCellColor
        self.navbarTitleAttrs = type == .dark ? [NSAttributedString.Key.foregroundColor: UIColor.white] : [NSAttributedString.Key.foregroundColor: UIColor.black]
        //if type == .dark { self.portalListCellContainerColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1) }
        
    }

    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.type == rhs.type
    }
}
