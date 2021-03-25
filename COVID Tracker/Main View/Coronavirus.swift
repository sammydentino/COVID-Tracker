//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct Coronavirus: View {
	@State var selected = 0
	@State public var searchQuery : String = ""
    @State var maintab = 0
    @ObservedObject private var fetch = getAll()
    @State var loading = false
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
        TabView(selection: $selected) {
            NavigationView {
                ZStack {
                    if selected != 0 {
                        EmptyView()
                    } else {
                        TotalView(fetch: fetch)
                    }
                }.navigationBarTitle(Text("COVID-19 Tracker"), displayMode: .large).animation(.default)
                .pullToRefresh(isShowing: $loading) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        fetch.loadAll()
                        fetch.loadExtras()
                        loading = false
                    }
                }
            }.tag(0)
                .tabItem {
                    Label("Tracker", systemImage: "antenna.radiowaves.left.and.right")
                }
            NavigationView {
                ZStack {
                    if selected != 1 {
                        EmptyView()
                    } else {
                        NewsView(fetch: fetch)
                    }
                }.navigationBarTitle(Text("News"), displayMode: .large).animation(.default)
                .pullToRefresh(isShowing: $loading) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        fetch.loadNews()
                        loading = false
                    }
                }
            }.tag(1)
                .tabItem {
                    Label("News", systemImage: "filemenu.and.selection")
                }
            NavigationView {
                ZStack {
                    if selected != 2 {
                        EmptyView()
                    } else {
                        CountryView(fetch: fetch)
                    }
                }.navigationBarTitle(Text("Countries"), displayMode: .large).animation(.default)
                .pullToRefresh(isShowing: $loading) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        fetch.loadCountries()
                        for item in fetch.countries! {
                            if item.country == "USA" {
                                fetch.usa = item
                            }
                        }
                        fetch.countries! = fetch.countries!.filter({
                            $0.country != "USA"
                        })
                        fetch.usa!.country = "United States"
                        fetch.countries!.append(fetch.usa!)
                        fetch.countries! = fetch.countries!.sorted(by: {
                            $0.active > $1.active
                        })
                        loading = false
                    }
                }
            }.tag(2)
                .tabItem {
                    Label("Countries", systemImage: "globe")
                }
            NavigationView {
                ZStack {
                    if selected != 3 {
                        EmptyView()
                    } else {
                        VaccinationView(fetch: fetch)
                    }
                }.navigationBarTitle("Vaccinations").animation(.default)
                .pullToRefresh(isShowing: $loading) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        fetch.loadVaccinations()
                        fetch.vaccinations = fetch.vaccinations.sorted(by: {
                            $0.data.last!.peopleFullyVaccinated ?? 0 > $1.data.last!.peopleFullyVaccinated ?? 0
                        })
                        fetch.worldvaccinations = fetch.vaccinations.first
                        loading = false
                    }
                }
            }.tag(3)
                .tabItem {
                    Label("Vaccinations", systemImage: "person.crop.square.fill.and.at.rectangle")
                }
            NavigationView {
                ZStack {
                    if selected != 4 {
                        EmptyView()
                    } else {
                        StatesView(fetch: fetch)
                    }
                }.navigationBarTitle("States").animation(.default)
                .pullToRefresh(isShowing: $loading) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        fetch.loadStates()
                        fetch.states = fetch.states.sorted(by: {
                            $0.active > $1.active
                        })
                        loading = false
                    }
                }
            }.tag(4)
                .tabItem {
                    Label("States", systemImage: "map")
                }
        }.navigationBarColor(UIColor.myControlBackground).navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        Coronavirus()
    }
}
