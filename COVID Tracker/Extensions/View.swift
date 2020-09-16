//
//  View.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/16/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI


extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
