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
    let portalListBackground: UIColor
    let tableViewCellBackgroundColor: UIColor
    let primary: UIColor
    let secondary: UIColor
    let complementary: UIColor
    let tint: UIColor

    static let light: ColorPalette = .init(
        textColor: .black,
        portalListBackground: .white,
        tableViewCellBackgroundColor: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1),
        primary: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1),
        secondary: UIColor(white: 0.4, alpha: 1.0),
        complementary: UIColor(white: 0.35, alpha: 1.0),
        tint: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1)
    )

    static let dark: ColorPalette = .init(
        textColor:.white,
        portalListBackground: UIColor(white: 0, alpha: 1.0),
        tableViewCellBackgroundColor: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1),
        primary: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1),
        secondary: UIColor(white: 0.6, alpha: 1.0),
        complementary: UIColor(white: 0.81, alpha: 1.0),
        tint: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)
    )

}
