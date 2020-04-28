//
//  CountryView.swift
//  COVID Tracker macOS
//
//  Created by Sammy Dentino on 4/25/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct DetailView: View {
	let country : Country
	
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
							Text(country.cases.withCommas())
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
							Text(country.active.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.blue)
						}
						Spacer()
						HStack {
							Text("Critical")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(country.critical.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.blue)
							
						}
						Spacer()
						HStack {
							Text("New Today").font(.subheadline).bold()
							Spacer()
							Text(country.todayCases.withCommas())
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
							Text(country.deaths.withCommas())
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
							Text(country.todayDeaths.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(.red)
						}
						Spacer()
					}
				}
				Section(header: Text("Recovered")
					.font(.headline)
					.foregroundColor(.green)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(country.recovered.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.green)
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
						Text(country.tests.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.purple)
					}
				}
			}
		}
	}
}

struct CountryView: View {
	@State private var searchQuery: String = ""
	var fetch = getCountries()
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			List(fetch.countries){ item in
				Section(header: Text("\nSorted by Most Cases")
					.font(.system(size: 12)).bold()
					.foregroundColor(.gray)) {
					NavigationLink(destination: DetailView(country: item)) {
						Text(item.country)
							.font(.subheadline)
							.bold()
							.padding()
					}
				}
			}
		}
	}
}

class getCountries {
	@Published var countries : [Country]!
	
	init() {
		loadCountries()
		countries = countries.sorted(by: {
			$0.cases > $1.cases
		})
	}
	
	func loadCountries() {
		let urlString = "https://corona.lmao.ninja/v2/countries"
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Country].self, from: d) {
					countries = data
				}
			}
		}
	}
}

struct Country : Codable, Identifiable {
	let id = UUID()
	let updated : Int!
	let country : String!
	//let countryInfo : CountryInfo!
	let cases : Int!
	let todayCases : Int!
	let deaths : Int!
	let todayDeaths : Int!
	let recovered : Int!
	let active : Int!
	let critical : Int!
	let casesPerOneMillion : Int!
	let deathsPerOneMillion : Int!
	let tests : Int!
	let testsPerOneMillion : Int!
	let continent : String!

	enum CodingKeys: String, CodingKey {
		case updated = "updated"
		case country = "country"
		//case countryInfo = "countryInfo"
		case cases = "cases"
		case todayCases = "todayCases"
		case deaths = "deaths"
		case todayDeaths = "todayDeaths"
		case recovered = "recovered"
		case active = "active"
		case critical = "critical"
		case casesPerOneMillion = "casesPerOneMillion"
		case deathsPerOneMillion = "deathsPerOneMillion"
		case tests = "tests"
		case testsPerOneMillion = "testsPerOneMillion"
		case continent = "continent"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		updated = try values.decodeIfPresent(Int.self, forKey: .updated)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		//countryInfo = try values.decodeIfPresent(CountryInfo.self, forKey: .countryInfo)
		cases = try values.decodeIfPresent(Int.self, forKey: .cases)
		todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases)
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths)
		todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths)
		recovered = try values.decodeIfPresent(Int.self, forKey: .recovered)
		active = try values.decodeIfPresent(Int.self, forKey: .active)
		critical = try values.decodeIfPresent(Int.self, forKey: .critical)
		casesPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .casesPerOneMillion)
		deathsPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .deathsPerOneMillion)
		tests = try values.decodeIfPresent(Int.self, forKey: .tests)
		testsPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .testsPerOneMillion)
		continent = try values.decodeIfPresent(String.self, forKey: .continent)
	}
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
