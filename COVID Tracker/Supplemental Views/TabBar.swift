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
                Image("Global")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primary)
                Text(self.index == 0 ? "Tracker" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 0 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 0
                }.minimumScaleFactor(0.5)
            HStack {
                Image("Country")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 30, height: 27.5)
                    .foregroundColor(.primary)
                Text(self.index == 1 ? "Countries" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 1 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 1
                }.minimumScaleFactor(0.5)
            HStack {
                Image("USA")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 35, height: 32.5)
                    .padding(.vertical, -7.5)
                    .foregroundColor(.primary)
                Text(self.index == 2 ? "States" : "").font(.system(size: 15, weight: .medium, design: .rounded))
            }.padding(15)
                .background(self.index == 2 ? themeColor : Color.clear)
                .clipShape(Capsule()).onTapGesture {
                    self.index = 2
                }.minimumScaleFactor(0.5)
            HStack {
                Image("News")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 27.5, height: 27.5)
                    .foregroundColor(.primary)
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
