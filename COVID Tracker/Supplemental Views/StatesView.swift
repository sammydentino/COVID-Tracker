//
//  StatesView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/17/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct DetailView2: View {
	let state : States
	@State private var showingDetail = false
	
	var body: some View {
		VStack {
			List {
				Section(header: Text("Cases")
					.font(.headline)
					.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(state.cases.withCommas())" )
								.font(.subheadline)
								.bold()
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
						}
						Spacer()
						HStack {
							Text("Active")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(state.active.withCommas())")
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Deaths")
					.font(.headline)
					.foregroundColor(.red)) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(state.deaths.withCommas())")
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Tests")
					.font(.headline)
					.foregroundColor(.green)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text("\(state.tests.withCommas())")
							.foregroundColor(.green)
							.font(.subheadline)
							.bold()
					}
				}
				Section(header: Text("Statistics")
					.font(.headline)
					.foregroundColor(.purple)) {
					VStack {
						Spacer()
						HStack {
							Text("Fatality Rate")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(state.deathRate, specifier: "%.2f")%")
								.foregroundColor(.purple)
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("Currently Active")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(state.activeVsConf, specifier: "%.2f")%")
								.foregroundColor(.purple)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
			}.listStyle(GroupedListStyle())
			Banner()
		}
	}
}

struct StatesView: View {
	@State private var searchQuery: String = ""
	@ObservedObject private var fetch = getStates()
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			SearchBar(text: self.$searchQuery).padding(.leading, 8).padding(.trailing, 8)
			List {
				Section(header: Text("Sorted by Most Cases").font(.subheadline).bold()) {
					ForEach(fetch.states.filter {
						self.searchQuery.isEmpty ? true : "\($0)".contains(self.searchQuery)
					}) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							Text("\(item.state)")
								.font(.subheadline)
								.bold()
								.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								 DetailView2(state: item).navigationBarTitle(item.state)
							}
						}
					}
				}
			}.listStyle(GroupedListStyle())
		}
	}
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        StatesView()
    }
}

class getStates : ObservableObject {
	@Published var states : [States]!
	
	init() {
		loadStates()
		states = states.sorted(by: {
			$0.cases > $1.cases
		})
	}
	
	func loadStates() {
		let statesString = "https://disease.sh/v2/states"
		
		if let url = URL(string: statesString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([States].self, from: d) {
					states = data
				}
			}
		}
	}
}

struct States : Codable, Identifiable {
	let id = UUID()
	let state : String!
	let cases : Int!
	let todayCases : Int!
	let deaths : Int!
	let todayDeaths : Int!
	let active : Int!
	let tests : Int!
	let testsPerOneMillion : Int!
	let deathRate: Double!
	let testedRate: Double!
	let activeVsConf: Double!

	enum CodingKeys: String, CodingKey {
		case state = "state"
		case cases = "cases"
		case todayCases = "todayCases"
		case deaths = "deaths"
		case todayDeaths = "todayDeaths"
		case active = "active"
		case tests = "tests"
		case testsPerOneMillion = "testsPerOneMillion"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		cases = try values.decodeIfPresent(Int.self, forKey: .cases)
		todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases)
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths)
		todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths)
		active = try values.decodeIfPresent(Int.self, forKey: .active)
		tests = try values.decodeIfPresent(Int.self, forKey: .tests)
		testsPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .testsPerOneMillion)
		deathRate = ((Double(deaths)) / (Double(cases))) * 100
		testedRate = ((Double(tests) / Double(cases))) * 100
		activeVsConf = ((Double(active) / Double(cases))) * 100
	}
}
