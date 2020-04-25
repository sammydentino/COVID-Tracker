//
//  TempView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/24/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TempView: View {
	var body: some View {
		Text("")
	}
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}

//Old Style Content View
/*
struct ContentView: View {
	
	@State var selectedView = 2
	@State public var searchQuery : String = ""
	
	init() {
		UINavigationBar.appearance().backgroundColor = .systemBackground
	}
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
		TabView(selection: $selectedView) {
			NavigationView {
				VStack {
					TestingView()
						.navigationBarTitle(Text("Testing Centers"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "info.circle")
				Text("Testing")
			}.tag(0)
			NavigationView {
				VStack {
					StatesView()
						.navigationBarTitle(Text("All States"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "house")
				Text("States")
			}.tag(1)
			NavigationView {
				VStack(alignment: .center, spacing: 0) {
					TempView()
						.navigationBarTitle(Text("COVID-19 Tracker"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "globe")
				Text("Global")
			}.tag(2)
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
			}.tag(3)
			NavigationView {
				VStack {
					NewsView()
						.navigationBarTitle(Text("News"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "tray.2")
				Text("News")
			}.tag(4)
			/*NavigationView {
				VStack {
					SourcesView()
						.navigationBarTitle(Text("Sources"))
					Banner()
				}
			}
			.navigationViewStyle(StackNavigationViewStyle())
				.tabItem {
				Image(systemName: "info.circle")
				Text("Sources")
			}.tag(5)*/
		}.animation(.default)
    }
}
*/
