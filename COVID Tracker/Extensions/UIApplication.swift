//
//  UIApplication.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/14/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

