//
//  ContentView.swift
//  COVID Tracker macOS
//
//  Created by Sammy Dentino on 4/25/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var selectedView = 2
	@State public var searchQuery : String = ""
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
		HStack {
			SourcesView()
			//CountryView()
			TotalView()
			//StatesView()
			TestingView()
		}
		/*TabView {
			NavigationView {
				VStack {
					TestingView()
						.navigationBarTitle(Text("Testing Centers"))
					//Banner()
				}
			}
				.tabItem {
				Image(systemName: "info.circle")
				Text("Testing")
			}.tag(0)
			NavigationView {
				VStack {
					StatesView()
						.navigationBarTitle(Text("All States"))
					//Banner()
				}
			}
				.tabItem {
				Image(systemName: "house")
				Text("States")
			}.tag(1)
			NavigationView {
				VStack(alignment: .center, spacing: 0) {
					TotalView()
						.navigationBarTitle(Text("Global"))
					//Banner()
				}
			}
				.tabItem {
				Image(systemName: "globe")
				Text("Global")
			}.tag(2)
			NavigationView {
				VStack {
					CountryView()
						.navigationBarTitle(Text("All Countries"))
					//Banner()
				}
			}
				.tabItem {
				Image(systemName: "map")
				Text("Countries")
			}.tag(3)
			NavigationView {
				VStack {
					SourcesView()
						.navigationBarTitle(Text("Sources"))
					//Banner()
				}
			}
				.tabItem {
				Image(systemName: "info.circle")
				Text("Sources")
			}.tag(4)
		}*/
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
