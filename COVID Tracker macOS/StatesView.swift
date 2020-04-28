//
//  StatesView.swift
//  COVID Tracker macOS
//
//  Created by Sammy Dentino on 4/25/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct DetailView2: View {
	let state : States
	
	var body: some View {
		VStack {
			List {
				Section(header: Text("\nCases")
					.font(.headline)
					.foregroundColor(.blue)) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(state.cases.withCommas() )
								.font(.subheadline)
								.bold()
								.foregroundColor(.blue)
						}
						Spacer()
						HStack {
							Text("Active")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(state.active.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.blue)
						}
						Spacer()
						HStack {
							Text("New Today")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(state.todayCases.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.blue)
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
							Text(state.deaths.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.red)
						}
						Spacer()
						HStack {
							Text("New Today")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(state.todayDeaths.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.red)
						}
						Spacer()
					}
				}
				Section(header: Text("Tests")
					.font(.headline)
					.foregroundColor(.purple)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(state.tests.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.purple)
					}
				}
			}
		}
	}
}

struct StatesView: View {
	@State private var searchQuery: String = ""
	var fetch = getStates()
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			List(fetch.states) { item in
				Section(header: Text("\nSorted by Most Cases")
					.font(.system(size: 12)).bold()
					.foregroundColor(.gray)) {
					NavigationLink(destination: DetailView2(state: item))
					{
						Text(item.state)
							.font(.subheadline)
							.bold()
							.padding()
					}
				}
			}
		}
	}
}

class getStates {
	@Published var states : [States]!
	
	init() {
		loadStates()
	}
	
	func loadStates() {
		let statesString = "https://corona.lmao.ninja/v2/states"
		
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
	}
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        StatesView()
    }
}
