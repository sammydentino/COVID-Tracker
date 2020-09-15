//
//  CountryView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct DetailView: View {
	let country : Countries
	
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
							Text("\(country.confirmed.withCommas())")
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("Active")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(country.active.withCommas())")
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
							Text("\(country.deaths.withCommas())")
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Recovered")
					.font(.headline)
					.foregroundColor(.green)) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(country.recovered.withCommas())")
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
						}
						Spacer()
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
							Text("\(country.deathRate, specifier: "%.2f")%")
								.foregroundColor(.purple)
								.font(.subheadline)
								.bold()
						}
						Spacer()
						/*HStack {
							Text("Recovery Rate")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(country.recoveredRate, specifier: "%.2f")%")
								.foregroundColor(.purple)
								.font(.subheadline)
								.bold()
						}
						Spacer()*/
						HStack {
							Text("Currently Active")
								.font(.subheadline)
								.bold()
							Spacer()
							Text("\(country.activeVsConf, specifier: "%.2f")%")
								.foregroundColor(.purple)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
			}.listStyle(GroupedListStyle())
			//Banner()
		}
	}
}

struct CountryView: View {
	@State private var searchQuery: String = ""
    let fetch: getCountries!
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 2.5).padding(.top, -10).padding(.bottom, 5)
			List {
				Section(header: Text("\nSorted by Most Cases").font(.subheadline).bold()) {
                    ForEach(fetch.countries.filter({ searchQuery.isEmpty ? true : $0.location.lowercased().contains(searchQuery.lowercased()) })) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							Text("\(item.location)")
								.font(.subheadline)
								.bold()
								.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								DetailView(country: item).navigationBarTitle(item.location)
							}
						}
					}
				}
			}.listStyle(GroupedListStyle())
		}
	}
}

class getCountries: ObservableObject {
	@Published var countries : [Countries]!
	
	init() {
        DispatchQueue.main.async {
            self.loadCountries()
            self.countries = self.countries.sorted(by: {
                $0.confirmed > $1.confirmed
            })
        }
	}
	
	func loadCountries() {
		let urlString = "https://covid2019-api.herokuapp.com/v2/current"
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(CountriesIn.self, from: d) {
					countries = data.data
				}
			}
		}
	}
}

struct CountriesIn : Codable {
	let data : [Countries]!
	let dt : String?
	let ts : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case dt = "dt"
		case ts = "ts"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([Countries].self, forKey: .data)
		dt = try values.decodeIfPresent(String.self, forKey: .dt)
		ts = try values.decodeIfPresent(Int.self, forKey: .ts)
	}

}

struct Countries : Codable, Identifiable {
	let id = UUID()
	let location : String!
	let confirmed : Int!
	let deaths : Int!
	let recovered : Int!
	let active : Int!
	let deathRate: Double!
	let recoveredRate: Double!
	let activeVsConf: Double!

	enum CodingKeys: String, CodingKey {
		case location = "location"
		case confirmed = "confirmed"
		case deaths = "deaths"
		case recovered = "recovered"
		case active = "active"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location = try values.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
		confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
		recovered = try values.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
		active = try values.decodeIfPresent(Int.self, forKey: .active) ?? 0
		deathRate = ((Double(deaths)) / (Double(confirmed))) * 100
		recoveredRate = ((Double(recovered) / Double(confirmed))) * 100
		activeVsConf = ((Double(active) / Double(confirmed))) * 100
	}
}
