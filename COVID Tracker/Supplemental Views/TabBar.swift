//
//  TabBar.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/14/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @Binding var index: Int

    private var bottomPadding: CGFloat {
        if !UIDevice.current.hasNotch {
            return 15
        } else {
            return 0
        }
    }
    
    private var themeColor: Color {
        if index == 0 {
            return Color(UIColor(red: 0, green: 0.7137, blue: 1.0, alpha: 1.0)).opacity(0.5)
        } else if index == 1 {
            return Color(.systemGreen).opacity(0.5)
        } else if index == 2 {
            return Color(.orange).opacity(0.5)
        } else {
            return Color(.systemRed).opacity(0.5)
        }
    }

    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 22.5, height: 22.5)
                Text(self.index == 0 ? "Global" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 0 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 0
                }.minimumScaleFactor(0.5)
            HStack {
                Image(systemName: "map")
                    .resizable()
                    .frame(width: 25, height: 22.5)
                Text(self.index == 1 ? "Countries" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 1 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 1
                }.minimumScaleFactor(0.5)
            HStack {
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 22.5, height: 22.5)
                Text(self.index == 2 ? "States" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 2 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 2
                }.minimumScaleFactor(0.5)
            HStack {
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 22.5, height: 22.5)
                Text(self.index == 4 ? "News" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 4 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 4
                }.minimumScaleFactor(0.5)
        }.padding(.top, 7.5)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.clear.edgesIgnoringSafeArea(.bottom))
            .padding(.bottom, self.bottomPadding)
            .animation(.default)
    }
}
