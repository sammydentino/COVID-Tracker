//
//  TotalView.swift
//  COVIDradar
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TotalView: View {
	@ObservedObject var fetch = getAll()
	@State var showingDetail = false
	
	var body: some View {
		VStack (alignment: .center, spacing: 0) {
			List {
				Section(header: Text("\nCases")
					.font(.headline).foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.global.cases.withCommas())
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
							Text(fetch.global.active.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack{
							Text("Critical")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.global.critical.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
						}
						Spacer()
						HStack {
							Text("New Today")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.global.todayCases.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
						}
						Spacer()
					}
					Button(action: {
						self.showingDetail.toggle()
					}) {
						Text("View Source Information")
							.font(.subheadline)
							.bold()
					}.sheet(isPresented: $showingDetail) {
						NavigationView {
							SourcesView().navigationBarTitle("Sources")
						}
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
							Text(fetch.global.deaths.withCommas())
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
							Text(fetch.global.todayDeaths.withCommas())
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
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.global.recovered.withCommas())
								.foregroundColor(.orange)
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
						Text(fetch.global.tests.withCommas())
							.foregroundColor(.green)
							.font(.subheadline)
							.bold()
					}
				}
				Section(header: Text("Affected Areas")
					.font(.headline)
					.foregroundColor(.purple)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.affectedCountries.withCommas())
							.foregroundColor(.purple)
							.font(.subheadline)
							.bold()
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
			Banner()
		}
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
		TotalView()
    }
}

class getAll : ObservableObject {
	@Published var global : Global!
	
	init() {
		loadAll()
	}
	func loadAll(){
		let urlString = "https://disease.sh/v2/all"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(Global.self, from: d) {
					global = data
				}
			}
		}
	}
}

struct Global : Codable {
	let updated : Int?
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
	let testsPerOneMillion : Double!
	let affectedCountries : Int!

	enum CodingKeys: String, CodingKey {
		case updated = "updated"
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
		case affectedCountries = "affectedCountries"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		updated = try values.decodeIfPresent(Int.self, forKey: .updated)
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
		testsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .testsPerOneMillion)
		affectedCountries = try values.decodeIfPresent(Int.self, forKey: .affectedCountries)
	}
}
