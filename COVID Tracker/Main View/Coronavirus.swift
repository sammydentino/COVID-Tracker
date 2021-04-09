//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import PartialSheet
import SwiftUIRefresh

struct Coronavirus: View {
	@State var selected = 0
	@State public var searchQuery : String = ""
    @State var maintab = 0
    @ObservedObject private var fetch = getAll()
    @State var loading = false
    
    private var tabitems: [BottomBarItem] = [
            BottomBarItem(icon: "antenna.radiowaves.left.and.right", color: .primary, color2: .primary),
            BottomBarItem(icon: "checkmark.shield", color: .primary, color2: .primary),
            BottomBarItem(icon: "globe", color: .primary, color2: .primary),
            BottomBarItem(icon: "map", color: .primary, color2: .primary),
            BottomBarItem(icon: "filemenu.and.selection", color: .primary, color2: .primary)
        ]
    
    
	//tab controller -> navigation controller -> each tab's views
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                if selected == 0 {
                    TotalView(fetch: fetch).navigationBarTitle(Text("COVID-19 Tracker"), displayMode: .large).navigationBarColor(.myControlBackground).animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadAll()
                                fetch.loadExtras()
                                loading = false
                            }
                        }
                } else if selected == 1 {
                    VaccinationView(fetch: fetch).navigationBarTitle("Vaccinations").animation(.default)
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
                } else if selected == 2 {
                    CountryView(fetch: fetch).navigationBarTitle(Text("Countries"), displayMode: .large).animation(.default)
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
                } else if selected == 3 {
                    StatesView(fetch: fetch).navigationBarTitle("States").animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadStates()
                                fetch.states = fetch.states.sorted(by: {
                                    $0.active > $1.active
                                })
                                loading = false
                            }
                        }
                } else if selected == 4 {
                    NewsView(fetch: fetch).navigationBarTitle(Text("News"), displayMode: .large).navigationBarColor(.myControlBackground).animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadNews()
                                loading = false
                            }
                        }
                }
                BottomBar(selectedIndex: $selected, items: tabitems)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.top)
            }
        }
    }
	
    /*var body2: some View {
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
            }.tag(1)
                .tabItem {
                    Label("Vaccinations", systemImage: "checkmark.shield")
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
            }.tag(3)
                .tabItem {
                    Label("States", systemImage: "map")
                }
            NavigationView {
                ZStack {
                    if selected != 4 {
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
            }.tag(4)
                .tabItem {
                    Label("News", systemImage: "filemenu.and.selection")
                }
        }.navigationBarColor(UIColor.myControlBackground).navigationViewStyle(StackNavigationViewStyle())
        .addPartialSheet(style: PartialSheetStyle(background: .solid(Color(UIColor.tertiarySystemBackground)),
                                                  handlerBarColor: Color(UIColor.systemGray2),
                                                  enableCover: true,
                                                  coverColor: Color.black.opacity(0.4),
                                                  blurEffectStyle: nil,
                                                  cornerRadius: 10,
                                                  minTopDistance: 500
                         ))
    }*/
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        Coronavirus()
    }
}
