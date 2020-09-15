//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var selected = 0
	@State public var searchQuery : String = ""
    @State var maintab = 0
    @ObservedObject private var fetchall = getAll()
    @ObservedObject private var coronaCases = CoronaObservable()
    @ObservedObject private var fetchcountries = getCountries()
    @ObservedObject private var fetchstates = getStates()
    @ObservedObject private var fetchcounties = getCounties()
    @ObservedObject private var fetchtimeline = getTimeline()
    @ObservedObject private var fetchnews = getNews()
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
        VStack {
            ZStack {
                if selected == 0 {
                    NavigationView {
                        VStack {
                            ZStack {
                                if maintab == 0 {
                                    TotalView(fetch: fetchall)
                                        .navigationBarTitle(Text("COVID-19 Tracker")).animation(.default)
                                } else if maintab == 1 {
                                    MapView(coronaCases: coronaCases.caseAnnotations, totalCases: coronaCases.coronaOutbreak.totalCases)
                                        .navigationBarTitle(Text("Map")).animation(.default)
                                } else {
                                    TimelineView(fetch: fetchtimeline)
                                        .navigationBarTitle(Text("Timeline")).animation(.default)
                                }
                            }
                            Picker("", selection: self.$maintab) {
                                Text("Statistics").tag(0)
                                Text("Map").tag(1)
                                Text("Timeline").tag(2)
                            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 30).padding(.vertical, 2.5)
                        }
                    }.navigationViewStyle(StackNavigationViewStyle()).animation(.default)
                } else if selected == 1 {
                    NavigationView {
                        VStack {
                            CountryView(fetch: fetchcountries)
                                .navigationBarTitle(Text("Countries")).animation(.default)
                        }
                    }.navigationViewStyle(StackNavigationViewStyle()).animation(.default)
                } else if selected == 2 {
                    NavigationView {
                        VStack {
                            StatesCombinedView(fetchstates: fetchstates, fetchcounties: fetchcounties).animation(.default)
                        }
                    }.navigationViewStyle(StackNavigationViewStyle()).animation(.default)
                } else {
                    NavigationView {
                        VStack {
                            NewsView(fetch: fetchnews)
                                .navigationBarTitle(Text("News")).animation(.default)
                        }
                    }.navigationViewStyle(StackNavigationViewStyle()).animation(.default)
                }
            }
            TabBar(index: $selected)
        }.gesture(DragGesture().onChanged{_ in
            UIApplication.shared.endEditing(true)
        }).animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        ContentView()
    }
}
