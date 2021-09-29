//
//  ColorPalette.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 19.09.2021.
//

import Foundation
import UIKit

struct ColorPalette {
    let textColor: UIColor
    let navigationbarColor: UIColor
    let navigationbarTextColor: UIColor
    let statusBarStyle: UIStatusBarStyle
    let background: UIColor
    let portalCellBackground: UIColor
    let navbarStyle: UIBarStyle
    let switchTintColor: UIColor
    let seperatorColor: UIColor
    let orangeUI: UIColor

    static let light: ColorPalette = .init(
        textColor: .black,
        navigationbarColor: .white,
        navigationbarTextColor: .black,
        statusBarStyle: .darkContent,
        background: .white,
        portalCellBackground: .clear,
        navbarStyle: UIBarStyle.default,
        switchTintColor: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1),
        seperatorColor: .black,
        orangeUI: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1)
    )

    static let dark: ColorPalette = .init(
        textColor: .white,
        navigationbarColor: .black,
        navigationbarTextColor: .white,
        statusBarStyle: .lightContent,
        background: .black,
        portalCellBackground: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1),
        navbarStyle: UIBarStyle.black,
        switchTintColor: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1),
        seperatorColor: .white,
        orangeUI: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1)
    )

}
