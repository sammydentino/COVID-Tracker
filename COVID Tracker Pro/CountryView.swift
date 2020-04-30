//
//  CountryView.swift
//  COVID Tracker (No Ads)
//
//  Created by Sammy Dentino on 4/29/20.
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
					.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(country.cases.withCommas())
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
							Text(country.active.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("Critical")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(country.critical.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							
						}
						Spacer()
						HStack {
							Text("New Today").font(.subheadline).bold()
							Spacer()
							Text(country.todayCases.withCommas())
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
							Text(country.deaths.withCommas())
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("New Today")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(country.todayDeaths.withCommas())
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Recovered")
					.font(.headline)
					.foregroundColor(.orange)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(country.recovered.withCommas())
							.foregroundColor(.orange)
							.font(.subheadline)
							.bold()
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
						Text(country.tests.withCommas())
							.foregroundColor(.green)
							.font(.subheadline)
							.bold()
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
		}
	}
}

struct CountryView: View {
	@State private var searchQuery: String = ""
	@ObservedObject var fetch = getCountries()
	@State var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			SearchBar(text: self.$searchQuery,
					  placeholder: "Case Sensitive").padding(8)
			List {
				Section(header: Text("\nSorted by Most Cases")
					.font(.system(size: 12))
					.foregroundColor(.gray).bold()) {
					ForEach(fetch.countries.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.country) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							Text(item.country)
								.font(.subheadline)
								.bold()
								.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								DetailView(country: item).navigationBarTitle(item.country)
							}
						}.buttonStyle(PlainButtonStyle())
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
		}
	}
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}

class getCountries: ObservableObject {
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

/*struct CountryInfo : Codable {
	let lat : String!
	let long : String!

	enum CodingKeys: String, CodingKey {
		case lat = "lat"
		case long = "long"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		long = try values.decodeIfPresent(String.self, forKey: .long)
	}
}*/
