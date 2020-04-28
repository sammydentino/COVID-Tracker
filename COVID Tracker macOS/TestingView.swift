//
//  TestingView.swift
//  COVID Tracker macOS
//
//  Created by Sammy Dentino on 4/25/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TestingView: View {
    @State private var searchQuery: String = ""
	var fetch = getTesting()
	
	var body: some View {
		VStack {
			List {
				Section(header: Text("\nArizona").font(.subheadline)
				.bold()) {
					ForEach(fetch.arizona) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("California").font(.subheadline)
				.bold()) {
					ForEach(fetch.california) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Delaware").font(.subheadline)
				.bold()) {
					ForEach(fetch.delaware) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Florida").font(.subheadline)
				.bold()) {
					ForEach(fetch.florida) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Massachusetts").font(.subheadline)
				.bold()) {
					ForEach(fetch.massachusetts) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Nevada").font(.subheadline)
				.bold()) {
					ForEach(fetch.nevada) { item in
						NavigationLink(destination: TestDetail(item: item)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.font(.subheadline)
									.bold()
									.padding()
								Spacer()
							}
						}
					}
				}
				/*Section(header: Text("New Jersey")) {
					ForEach(fetch.newJersey.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("New York")) {
					ForEach(fetch.newYork.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Pennsylvania")) {
					ForEach(fetch.pennsylvania.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Texas")) {
					ForEach(fetch.texas.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}*/
				/*Section(header: Text("Utah")) {
					ForEach(fetch.utah.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}
				Section(header: Text("Washington")) {
					ForEach(fetch.washington.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						NavigationLink(destination: TestDetail(item: item).navigationBarTitle(item.name)) {
							VStack(alignment:.leading){
								Spacer()
								Text(item.name)
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
									.font(.subheadline)
									.bold()
								Spacer()
							}
						}
					}
				}*/
			}
		}
	}
}

struct TestDetail: View {
	let item: Testing!
	
	var body: some View {
		VStack {
			List {
				Section(header: Text("\nName")
					.font(.subheadline)
					.bold().foregroundColor(.blue)) {
					VStack (alignment:.leading){
						Spacer()
						Text(item.name)
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
				Section(header: Text("Transportation")
					.font(.subheadline)
					.bold().foregroundColor(.red)) {
					VStack (alignment:.leading){
						Spacer()
						Text(item.transportation)
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
				Section(header: Text("Updated")
					.font(.subheadline)
					.bold().foregroundColor(.green)) {
					VStack (alignment:.leading){
						Spacer()
						Text(item.updated)
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
				Section(header: Text("Description")
					.font(.subheadline)
					.bold().foregroundColor(.purple)) {
					VStack (alignment:.leading){
						Spacer()
						Text(item.description)
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
			}
		}
	}
}

class getTesting {
	@Published var arizona : [Testing]!
	@Published var california : [Testing]!
	@Published var delaware : [Testing]!
	@Published var florida : [Testing]!
	@Published var massachusetts : [Testing]!
	@Published var nevada : [Testing]!
	@Published var newJersey : [Testing]!
	@Published var newYork : [Testing]!
	@Published var pennsylvania : [Testing]!
	@Published var texas : [Testing]!
	@Published var utah : [Testing]!
	@Published var washington : [Testing]!
	
	init() {
		loadArizona()
		loadCalifornia()
		loadDelaware()
		loadFlorida()
		loadMassachusetts()
		loadNevada()
		loadNewJersey()
		loadNewYork()
		loadPennsylvania()
		loadTexas()
		loadUtah()
		loadWashington()
	}
	func loadArizona() {
		let urlString = "https://covid-19-testing.github.io/locations/arizona/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					arizona = data
				}
			}
		}
	}
	func loadCalifornia() {
		let urlString = "https://covid-19-testing.github.io/locations/california/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					california = data
				}
			}
		}
	}
	func loadDelaware() {
		let urlString = "https://covid-19-testing.github.io/locations/delaware/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					delaware = data
				}
			}
		}
	}
	func loadFlorida() {
		let urlString = "https://covid-19-testing.github.io/locations/florida/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					florida = data
				}
			}
		}
	}
	func loadMassachusetts() {
		let urlString = "https://covid-19-testing.github.io/locations/massachusetts/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					massachusetts = data
				}
			}
		}
	}
	func loadNevada() {
		let urlString = "https://covid-19-testing.github.io/locations/nevada/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					nevada = data
				}
			}
		}
	}
	func loadNewJersey() {
		let urlString = "https://covid-19-testing.github.io/locations/newjersey/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					newJersey = data
				}
			}
		}
	}
	func loadNewYork() {
		let urlString = "https://covid-19-testing.github.io/locations/newyork/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					newYork = data
				}
			}
		}
	}
	func loadPennsylvania() {
		let urlString = "https://covid-19-testing.github.io/locations/pennsylvania/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					pennsylvania = data
				}
			}
		}
	}
	func loadTexas() {
		let urlString = "https://covid-19-testing.github.io/locations/texas/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					texas = data
				}
			}
		}
	}
	func loadUtah() {
		let urlString = "https://covid-19-testing.github.io/locations/utah/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					utah = data
				}
			}
		}
	}
	func loadWashington() {
		let urlString = "https://covid-19-testing.github.io/locations/washington/complete.json"
		
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Testing].self, from: d) {
					washington = data
				}
			}
		}
	}
}

struct Testing : Codable, Identifiable {
	let id = UUID()
	let organization_id : String!
	let name : String!
	let alternate_name : String!
	let description : String!
	let transportation : String!
	let updated : String!
	let featured : String!
	let physical_address : [Physical_address]!
	let phones : [Phones]!
	let regular_schedule : [Regular_schedule]!

	enum CodingKeys: String, CodingKey {
		//case id = "id"
		case organization_id = "organization_id"
		case name = "name"
		case alternate_name = "alternate_name"
		case description = "description"
		case transportation = "transportation"
		case updated = "updated"
		case featured = "featured"
		case physical_address = "physical_address"
		case phones = "phones"
		case regular_schedule = "regular_schedule"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		organization_id = try values.decodeIfPresent(String.self, forKey: .organization_id)
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
		alternate_name = try values.decodeIfPresent(String.self, forKey: .alternate_name) ?? "N/A"
		description = try values.decodeIfPresent(String.self, forKey: .description) ?? "N/A"
		transportation = try values.decodeIfPresent(String.self, forKey: .transportation) ?? "N/A"
		updated = try values.decodeIfPresent(String.self, forKey: .updated) ?? "N/A"
		featured = try values.decodeIfPresent(String.self, forKey: .featured) ?? "N/A"
		physical_address = try values.decodeIfPresent([Physical_address].self, forKey: .physical_address)
		phones = try values.decodeIfPresent([Phones].self, forKey: .phones)
		regular_schedule = try values.decodeIfPresent([Regular_schedule].self, forKey: .regular_schedule)
	}
}

struct Physical_address : Codable, Identifiable {
	let id = UUID()
	let location_id : String!
	let address_1 : String!
	let city : String!
	let region : String!
	let state_province : String!
	let postal_code : String!
	let country : String!

	enum CodingKeys: String, CodingKey {
		//case id = "id"
		case location_id = "location_id"
		case address_1 = "address_1"
		case city = "city"
		case region = "region"
		case state_province = "state_province"
		case postal_code = "postal_code"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		//id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		address_1 = try values.decodeIfPresent(String.self, forKey: .address_1)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		region = try values.decodeIfPresent(String.self, forKey: .region)
		state_province = try values.decodeIfPresent(String.self, forKey: .state_province)
		postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}
}

struct Regular_schedule : Codable, Identifiable {
	let id = UUID()
	let location_id : String!
	let weekday : String!
	let opens_at : String!
	let closes_at : String!

	enum CodingKeys: String, CodingKey {
		//case id = "id"
		case location_id = "location_id"
		case weekday = "weekday"
		case opens_at = "opens_at"
		case closes_at = "closes_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		//id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		weekday = try values.decodeIfPresent(String.self, forKey: .weekday)
		opens_at = try values.decodeIfPresent(String.self, forKey: .opens_at)
		closes_at = try values.decodeIfPresent(String.self, forKey: .closes_at)
	}
}

struct Phones : Codable, Identifiable {
	let id = UUID()
	let location_id : String!
	let number : String!
	let ext : String!
	let type : String!
	let language : String!
	let description : String!

	enum CodingKeys: String, CodingKey {
		//case id = "id"
		case location_id = "location_id"
		case number = "number"
		case ext = "extension"
		case type = "type"
		case language = "language"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		//id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		number = try values.decodeIfPresent(String.self, forKey: .number)
		ext = try values.decodeIfPresent(String.self, forKey: .ext)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
