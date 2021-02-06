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
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
        NavigationView {
            VStack {
                if selected == 0 {
                    Picker("", selection: self.$maintab) {
                        Text("Statistics").tag(0)
                        Text("Map").tag(1)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 15).padding(.vertical, 2.5).padding(.bottom, 5)
                }
                ZStack {
                    if selected == 0 {
                        if maintab == 0 {
                            TotalView(fetch: fetch)
                                .navigationBarTitle(Text("COVID-19 Tracker"), displayMode: .large).animation(.default)
                        } else if maintab == 1 {
                            MapView(coronaCases: coronaCases.caseAnnotations, totalCases: coronaCases.coronaOutbreak.totalCases)
                                .navigationBarTitle(Text("COVID-19 Tracker"), displayMode: .large).animation(.default)
                        }
                    } else if selected == 1 {
                        CountryView(fetch: fetch)
                            .navigationBarTitle(Text("Countries"), displayMode: .large).animation(.default)
                    } else if selected == 2 {
                        StatesView(fetch: fetch).navigationBarTitle("States")
                    } else {
                        NewsView(fetch: fetch)
                            .navigationBarTitle(Text("News"), displayMode: .large).animation(.default)
                    }
                }
                TabBar(index: $selected)
            }.gesture(DragGesture().onChanged{_ in
                UIApplication.shared.endEditing(true)
            }).animation(.default)
        }.navigationBarColor(UIColor.myControlBackground).navigationViewStyle(StackNavigationViewStyle()).animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        Coronavirus()
    }
}
