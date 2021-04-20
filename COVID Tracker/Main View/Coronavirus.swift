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
    @State var showingsettings = false
    let app = AKApp(id: "0", name: "COVID Tracker", appIcon: UIImage(named: "AppIcon"), developer: AKDeveloper(id: "1509369331", name: "Sammy Dentino", twitterHandle: "sammydentino"), email: "sammydentino@hackermail.com", twitterHandle: nil, websiteURL: "https://www.sammydentino.dev", privacyPolicyURL: nil)
    let clear = AKOtherApp(id: "1514988096", name: "Clear Weather")
    let wordfinder = AKOtherApp(id: "1516219007", name: "Word Finder")
    let docket = AKOtherApp(id: "1546403649", name: "Docket")
    
    private var tabitems: [BottomBarItem] = [
            BottomBarItem(icon: "antenna.radiowaves.left.and.right"),
            BottomBarItem(icon: "checkmark.shield"),
            BottomBarItem(icon: "globe"),
            BottomBarItem(icon: "map"),
            BottomBarItem(icon: "filemenu.and.selection")
        ]
    
    
	//tab controller -> navigation controller -> each tab's views
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                if selected == 0 {
                    TotalView(fetch: fetch).navigationBarTitle(Text("COVID-19 Tracker"), displayMode: .large).navigationBarColor(.myControlBackground).navigationBarItems(trailing:
                            Button(action: {
                                showingsettings = true
                            }) {
                                Image(systemName: "info.circle.fill").foregroundColor(.primary).font(.title2)
                            }
                        ).animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadAll()
                                fetch.loadExtras()
                                loading = false
                            }
                        }
                } else if selected == 1 {
                    VaccinationView(fetch: fetch).navigationBarTitle("Vaccinations")
                        .navigationBarItems(trailing:
                                Button(action: {
                                    showingsettings = true
                                }) {
                                    Image(systemName: "info.circle.fill").foregroundColor(.primary).font(.title2)
                                }
                            )
                        .animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadVaccinations()
                                fetch.vaccinations = fetch.vaccinations.sorted(by: {
                                    $0.data.last!.peopleFullyVaccinated ?? 0 > $1.data.last!.peopleFullyVaccinated ?? 0
                                })
                                fetch.worldvaccinations = fetch.vaccinations.first
                                fetch.vaccinations = Array(fetch.vaccinations.dropFirst())
                                loading = false
                            }
                        }
                } else if selected == 2 {
                    CountryView(fetch: fetch).navigationBarTitle(Text("Countries"), displayMode: .large)
                        .navigationBarItems(trailing:
                                Button(action: {
                                    showingsettings = true
                                }) {
                                    Image(systemName: "info.circle.fill").foregroundColor(.primary).font(.title2)
                                }
                            )
                        .animation(.default)
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
                    StatesView(fetch: fetch).navigationBarTitle("States")
                        .navigationBarItems(trailing:
                                Button(action: {
                                    showingsettings = true
                                }) {
                                    Image(systemName: "info.circle.fill").foregroundColor(.primary).font(.title2)
                                }
                            )
                        .animation(.default)
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
                    NewsView(fetch: fetch).navigationBarTitle(Text("News"), displayMode: .large).navigationBarColor(.myControlBackground)
                        .navigationBarItems(trailing:
                                Button(action: {
                                    showingsettings = true
                                }) {
                                    Image(systemName: "info.circle.fill").foregroundColor(.primary).font(.title2)
                                }
                            )
                        .animation(.default)
                        .pullToRefresh(isShowing: $loading) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                fetch.loadNews()
                                loading = false
                            }
                        }
                }
                BottomBar(selectedIndex: $selected, items: tabitems)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
                    .padding(.top)
                    .shadow(radius: 10)
                    .onChange(of: selected, perform: { value in
                        taptic()
                    })
                    .sheet(isPresented: $showingsettings) {
                        AboutAppWithNavigationView(app: app, otherApps: [clear, wordfinder, docket], titleDisplayMode: .large)
                    }
            }.ignoresSafeArea(.keyboard)
        }
    }
}
