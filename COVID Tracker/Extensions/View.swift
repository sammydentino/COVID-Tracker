//
//  View.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/16/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

extension View {
    //dismiss keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    //fixes capitalization bug in iOS 14
    @ViewBuilder func fixCase() -> some View {
        if #available(iOS 14.0, *) {
            self.textCase(.none)
        } else {
            self
        }
    }
    
    //fixes the different list styles for 13 & 14
    @ViewBuilder func fixList() -> some View {
        if #available(iOS 14.0, *) {
            self.listStyle(InsetGroupedListStyle())
        } else {
            self.listStyle(GroupedListStyle()).environment(\.horizontalSizeClass, .regular)
        }
    }
    
    //text style modifiers
    @ViewBuilder func tab(i: CGFloat) -> some View {
        self.font(.system(size: i, weight: .medium, design: .rounded))
    }
    @ViewBuilder func title() -> some View {
        self.font(.system(size: 28, weight: .bold, design: .rounded)).animation(.default).fixCase()
    }
    @ViewBuilder func subhead() -> some View {
        self.font(.system(size: 15, weight: .semibold, design: .rounded)).animation(.default).fixCase()
    }
    @ViewBuilder func head() -> some View {
        self.font(.system(size: 17, weight: .light, design: .rounded)).animation(.default).fixCase()
    }
    @ViewBuilder func caption() -> some View {
        self.font(.system(size: 12, weight: .bold, design: .rounded)).animation(.default).fixCase()
    }
    @ViewBuilder func textColor(i: Color) -> some View {
        self.foregroundColor(i)
    }
    @ViewBuilder func bgColor(i: Color) -> some View {
        self.background(i)
    }
    
    //padding shorthand functions
    @ViewBuilder func pad(i: CGFloat) -> some View {
        self.padding(i)
    }
    @ViewBuilder func hPad(i: CGFloat) -> some View {
        self.padding(.horizontal, i)
    }
    @ViewBuilder func vPad(i: CGFloat) -> some View {
        self.padding(.vertical, i)
    }
    @ViewBuilder func aPad(i: CGFloat) -> some View {
        self.padding(.all, i)
    }
    @ViewBuilder func tPad(i: CGFloat) -> some View {
        self.padding(.top, i)
    }
    @ViewBuilder func bPad(i: CGFloat) -> some View {
        self.padding(.bottom, i)
    }
    @ViewBuilder func lPad(i: CGFloat) -> some View {
        self.padding(.leading, i)
    }
    @ViewBuilder func rPad(i: CGFloat) -> some View {
        self.padding(.trailing, i)
    }
    
    //navigation view builders
    @ViewBuilder func makeNav() -> some View {
        NavigationView {
            self
        }.navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(UIColor.myControlBackground)
    }
    @ViewBuilder func makeHomeNav() -> some View {
        NavigationView {
            self
        }.navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(UIColor.myControlBackground).bPad(i: -7.5)
    }
    @ViewBuilder func makeRadarNav() -> some View {
        NavigationView {
            self.edgesIgnoringSafeArea(.bottom)
        }.navigationViewStyle(StackNavigationViewStyle()).navigationBarColor(UIColor.myControlBackground)
    }
    
    @ViewBuilder func makeVStack() -> some View {
        if #available(iOS 14.0, *) {
            LazyVStack(alignment: .leading, spacing: 0) {
                self
            }
        } else {
            VStack(alignment: .leading, spacing: 0) {
                self
            }
        }
    }
    
    //list section builders
    @ViewBuilder func makeColoredSection(str: String, color: Color) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("   \(str)")
                .font(.headline)
                .foregroundColor(color)
                .bold()
                .fixCase()) {
                self
            }
        } else {
            Section(header: Text("\(str)")
                .font(.headline)
                .foregroundColor(color)
                .bold()
                .fixCase()) {
                self
            }
        }
    }
    @ViewBuilder func makeNewLineColoredSection(str: String, color: Color) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("\n   \(str)")
                .font(.headline)
                .foregroundColor(color)
                .bold()
                .fixCase()) {
                self
            }
        } else {
            Section(header: Text("\n\(str)")
                .font(.headline)
                .foregroundColor(color)
                .bold()
                .fixCase()) {
                self
            }
        }
    }
    @ViewBuilder func makeSection(str: String) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("   \(str)").subhead()) {
                self
            }
        } else {
            Section(header: Text("\(str)").subhead()) {
                self
            }
        }
    }
    @ViewBuilder func makeNewLineSection(str: String) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("\n   \(str)").subhead()) {
                self
            }
        } else {
            Section(header: Text("\n\(str)").subhead()) {
                self
            }
        }
    }
    @ViewBuilder func makeNewLineSectionBoth(str: String, str2: String) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("\n   \(str)").subhead(), footer: Text("   \(str2)").caption()) {
                self
            }
        } else {
            Section(header: Text("\n\(str)").subhead(), footer: Text("\(str2)").caption()) {
                self
            }
        }
    }
    @ViewBuilder func makeDarkSection(str: String) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("   \(str)").subhead().foregroundColor(.primary)) {
                self
            }
        } else {
            Section(header: Text("\(str)").subhead().foregroundColor(.primary)) {
                self
            }
        }
    }
    @ViewBuilder func makeDarkNewLineSection(str: String) -> some View {
        if #available(iOS 14.0, *) {
            Section(header: Text("\n   \(str)").subhead().foregroundColor(.primary)) {
                self
            }
        } else {
            Section(header: Text("\n\(str)").subhead().foregroundColor(.primary)) {
                self
            }
        }
    }
    @ViewBuilder func makeEmptySection() -> some View {
        Section(header: Text(" ")) {
            self
        }
    }
    
    //navigation bar title setters
    @ViewBuilder func sTitle(str: String) -> some View {
        self.navigationBarTitle("\(str)", displayMode: .inline)
    }
    @ViewBuilder func lTitle(str: String) -> some View {
        self.navigationBarTitle("\(str)", displayMode: .large)
    }
    
    //navigation stack style setter
    @ViewBuilder func navStack() -> some View {
        self.navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder func navButton(actionin: (() -> Void)?, str: String) -> some View {
        self.navigationBarItems(leading:
            Button(action: {
                    actionin?()
            }) {
                Text(str).subhead().textColor(i: .secondary)
            })
    }
    
    //set nav bar color
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
