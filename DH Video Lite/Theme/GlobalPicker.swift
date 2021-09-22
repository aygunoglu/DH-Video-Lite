//
//  GlobalPicker.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 21.09.2021.
//

import SwiftTheme

enum GlobalPicker {
    static let backgroundColor: ThemeColorPicker = ["#fff", "#fff", "#fff", "#292b38"]
    static let textColor: ThemeColorPicker = ["#000", "#000", "#000", "#ECF0F1"]
    
    static let barTextColors = ["#FFF", "#000", "#FFF", "#FFF"]
    static let barTextColor = ThemeColorPicker.pickerWithColors(barTextColors)
    static let barTintColor: ThemeColorPicker = ["#EB4F38", "#F4C600", "#56ABE4", "#01040D"]
}
