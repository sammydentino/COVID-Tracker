//
//  UIColor.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/16/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

extension UIColor {
    static let myControlBackground: UIColor = dynamicColor(light: UIColor.white, dark: UIColor.black)
    static let myControlText: UIColor = dynamicColor(light: UIColor.black, dark: UIColor.white)
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}
