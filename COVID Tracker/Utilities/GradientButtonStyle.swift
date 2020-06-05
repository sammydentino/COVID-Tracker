//
//  GradientButtonStyle.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/13/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
