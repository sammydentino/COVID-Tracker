//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct Coronavirus: View {
	@State var selected = 0
	@State public var searchQuery : String = ""
    @State var maintab = 0
    @ObservedObject private var fetch = getAll()
    @ObservedObject private var coronaCases = CoronaObservable()
    
    let coloredNavAppearance = UINavigationBarAppearance()
    
    init() {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let font = UIFont.init(descriptor: descriptor, size: 48)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font.bold()]
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.white
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredNavAppearance.largeTitleTextAttributes = [.font : font.bold(), .foregroundColor: UIColor.black]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if selected == 0 {
                        if maintab == 0 {
                            TotalView(fetch: fetch)
                                .navigationBarTitle(Text("COVID-19 Tracker")).animation(.default)
                        } else if maintab == 1 {
                            MapView(coronaCases: coronaCases.caseAnnotations, totalCases: coronaCases.coronaOutbreak.totalCases)
                                .navigationBarTitle(Text("Map")).animation(.default)
                        } else {
                            TimelineView(fetch: fetch)
                                .navigationBarTitle(Text("Timeline")).animation(.default)
                        }
                    } else if selected == 1 {
                        CountryView(fetch: fetch)
                            .navigationBarTitle(Text("Countries")).animation(.default)
                    } else if selected == 2 {
                        StatesCombinedView(fetch: fetch).animation(.default)
                    } else {
                        NewsView(fetch: fetch)
                            .navigationBarTitle(Text("News")).animation(.default)
                    }
                }
                if selected == 0 {
                    Picker("", selection: self.$maintab) {
                        Text("Statistics").tag(0)
                        Text("Map").tag(1)
                        Text("Timeline").tag(2)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 30).padding(.vertical, 2.5)
                }
                TabBar(index: $selected)
            }.gesture(DragGesture().onChanged{_ in
                UIApplication.shared.endEditing(true)
            }).animation(.default)
        }.navigationViewStyle(StackNavigationViewStyle()).animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        Coronavirus()
    }
}
