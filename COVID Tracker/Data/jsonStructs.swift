//
//  jsonStructs.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/22/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import Foundation

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
