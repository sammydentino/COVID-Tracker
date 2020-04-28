//
//  ContentView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
//import BottomBar_SwiftUI

struct ContentView: View {
	
	@State var selectedView = 2
	@State public var searchQuery : String = ""
	
	init() {
		UINavigationBar.appearance().backgroundColor = .systemBackground
	}
    
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
		/*UIKitTabView([
            UIKitTabView.Tab(view: TestingView(), title: "Testing", image: "info.circle"),
            UIKitTabView.Tab(view: CountryView(), title: "Countries", image: "map"),
			UIKitTabView.Tab(view: TotalView(), title: "Global", image: "globe"),
			UIKitTabView.Tab(view: StatesView(), title: "States", image: "house"),
			UIKitTabView.Tab(view: NewsView(), title: "News", image: "tray.2")
        ])*/
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
					TotalView()
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

/*
let items: [BottomBarItem] = [
    BottomBarItem(icon: "globe", title: "Global", color: .purple),
    BottomBarItem(icon: "map", title: "Countries", color: .pink),
    BottomBarItem(icon: "house", title: "States", color: .orange),
    BottomBarItem(icon: "person", title: "Testing", color: .blue)
]

struct ContentView: View {
	@State var selectedIndex: Int = 0
	
	var selectedItem: BottomBarItem {
		items[selectedIndex]
	}
	
	init() {
		UINavigationBar.appearance().backgroundColor = .systemBackground
	}
		
	//tab controller -> navigation controller -> each tab's views
	var body: some View {
		UIKitTabView([
            UIKitTabView.Tab(view: TestingView(), title: "Testing", image: "info.circle"),
            UIKitTabView.Tab(view: CountryView(), title: "Countries", image: "map"),
			UIKitTabView.Tab(view: TotalView(), title: "Global", image: "globe"),
			UIKitTabView.Tab(view: StatesView(), title: "States", image: "house"),
			UIKitTabView.Tab(view: NewsView(), title: "News", image: "tray.2")
        ])
		/*VStack {
			TabView(selection: $selectedIndex) {
				NavigationView {
					VStack(alignment: .center, spacing: 0) {
						TotalView()
							.navigationBarTitle(Text("\nGlobal"))
						Banner()
						BottomBar(selectedIndex: $selectedIndex, items: items)
					}
				}.navigationViewStyle(StackNavigationViewStyle())
				NavigationView {
					VStack {
						CountryView()
							.navigationBarTitle(Text("All Countries"))
						Banner()
						BottomBar(selectedIndex: $selectedIndex, items: items)
					}
				}.navigationViewStyle(StackNavigationViewStyle()).tag(1)
				NavigationView {
					VStack {
						StatesView()
							.navigationBarTitle(Text("All States"))
						Banner()
						BottomBar(selectedIndex: $selectedIndex, items: items)
					}
				}.navigationViewStyle(StackNavigationViewStyle()).tag(2)
				NavigationView {
					VStack {
						TestingView()
							.navigationBarTitle(Text("Testing Centers"))
						Banner()
						BottomBar(selectedIndex: $selectedIndex, items: items)
					}
				}.tag(3)
			}
		}.edgesIgnoringSafeArea(.all).padding(EdgeInsets(top: 2.5, leading: 0, bottom: 0, trailing: 0)).animation(.default)*/
	}
}*/

struct ContentView_Previews: PreviewProvider {
    
	static var previews: some View {
        ContentView()
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
	var placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
		searchBar.placeholder = placeholder
		searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

class AnyGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        //To prevent keyboard hide and show when switching from one textfield to another
        if let textField = touches.first?.view, textField is UITextField {
            state = .failed
        } else {
            state = .began
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}
