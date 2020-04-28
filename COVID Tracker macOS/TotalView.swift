//
//  TotalView.swift
//  COVID Tracker macOS
//
//  Created by Sammy Dentino on 4/25/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TotalView: View {
	var fetch = getAll()
	
	var body: some View {
		VStack (alignment: .leading, spacing: 0) {
			List {
				Spacer()
				VStack {
					Text("\nCases")
					.font(.headline).bold().foregroundColor(.blue)
					Spacer()
					HStack {
						Group {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.cases.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.blue)
						}
					}
					Spacer()
					HStack {
						Group {
						Text("Active")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.active.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.blue)
						}
					}
					Spacer()
					/*HStack{
						Text("Critical")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.critical.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.blue)
					}*/
					Spacer()
					HStack {
						Text("New Today")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.todayCases.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.blue)
					}
					Spacer()
					Text("github.com/CSSEGISandData/COVID-19")
					.font(.system(size: 12)).bold()
					.foregroundColor(.gray)
				}
				Spacer()
				VStack {
					Text("Deaths")
					.font(.headline)
					.foregroundColor(.red)
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.deaths.withCommas())
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
						Text(fetch.global.todayDeaths.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.red)
					}
					Spacer()
				}
				Spacer()
				VStack {
					Text("Recovered")
					.font(.headline)
					.foregroundColor(.orange)
					Spacer()
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.recovered.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.orange)
					}
					Spacer()
					HStack {
						Text("New Today")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.extras.global.newRecovered.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.orange)
					}
					Spacer()
				}
				Spacer()
				VStack {
					Text("Tests")
					.font(.headline)
					.foregroundColor(.green)
					HStack {
					Text("Total")
						.font(.subheadline)
						.bold()
					Spacer()
					Text(fetch.global.tests.withCommas())
						.font(.subheadline)
						.bold()
						.foregroundColor(.green)
					}
				}
				Spacer()
				VStack {
					Text("Affected Areas")
					.font(.headline)
					.foregroundColor(.purple)
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.affectedCountries.withCommas())
							.font(.subheadline)
							.bold()
							.foregroundColor(.purple)
					}
				}
				//Spacer()
			}
		}
    }
}

class getAll {
	@Published var global : Global!
	@Published var extras : Welcome!
	
	init() {
		loadAll()
		loadExtras()
	}
	func loadAll(){
		let urlString = "https://corona.lmao.ninja/v2/all"
		
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
	func loadExtras() {
		let urlString = "https://api.covid19api.com/summary"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(Welcome.self, from: d) {
					extras = data
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

// Welcome & GlobalExtras
struct Welcome : Codable {
	let global : GlobalExtras!

	enum CodingKeys: String, CodingKey {
		case global = "Global"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		global = try values.decodeIfPresent(GlobalExtras.self, forKey: .global)
	}
}

struct GlobalExtras : Codable {
	let newConfirmed : Int?
	let totalConfirmed : Int?
	let newDeaths : Int?
	let totalDeaths : Int?
	let newRecovered : Int!
	let totalRecovered : Int?

	enum CodingKeys: String, CodingKey {
		case newConfirmed = "NewConfirmed"
		case totalConfirmed = "TotalConfirmed"
		case newDeaths = "NewDeaths"
		case totalDeaths = "TotalDeaths"
		case newRecovered = "NewRecovered"
		case totalRecovered = "TotalRecovered"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		newConfirmed = try values.decodeIfPresent(Int.self, forKey: .newConfirmed)
		totalConfirmed = try values.decodeIfPresent(Int.self, forKey: .totalConfirmed)
		newDeaths = try values.decodeIfPresent(Int.self, forKey: .newDeaths)
		totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths)
		newRecovered = try values.decodeIfPresent(Int.self, forKey: .newRecovered)
		totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered)
	}
}
