//
//  UIDevice.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/14/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
}
