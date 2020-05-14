//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var selectedView = 0
	@State public var searchQuery : String = ""
	
	init() {
		UINavigationBar.appearance().backgroundColor = .systemBackground
	}
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
		TabView(selection: $selectedView) {
			NavigationView {
				VStack {
					MapsView()
						.navigationBarTitle(Text("COVID-19 Tracker"))
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "globe")
				Text("Global")
			}.tag(0)
			NavigationView {
				VStack {
					CountryView()
						.navigationBarTitle(Text("All Countries"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "map")
				Text("Countries")
			}.tag(1)
			NavigationView {
				VStack {
					StatesCombinedView()
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "book")
				Text("States")
			}.tag(2)
			NavigationView {
				VStack {
					NewsView()
						.navigationBarTitle(Text("News"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "paperplane")
				Text("News")
			}.tag(3)
		}.animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        ContentView()
    }
}
