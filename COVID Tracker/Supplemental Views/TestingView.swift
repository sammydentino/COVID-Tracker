//
//  TestingView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/23/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

/*
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
*/

struct TestingView: View {
    @State private var searchQuery: String = ""
	let locStates = ["Arizona", "California", "Delaware", "Florida", "Massachusetts", "Nevada", "New Jersey", "New York", "Pennsylvania", "Texas", "Utah", "Washington"]
	
	var body: some View {
		VStack {
			SearchBar(text: self.$searchQuery, placeholder: "Case Sensitive").padding(8)
			List(self.locStates, id: \.self) { item in
				NavigationLink(destination: DetailView4(loc: item).navigationBarTitle(item))
				{
					Text(item)
					.font(.subheadline)
					.bold()
					.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
				}
			}.listStyle(GroupedListStyle())
			.environment(\.horizontalSizeClass, .regular)
		}
	}
}

struct DetailView4: View {
	let loc : String
	@ObservedObject var fetch = getTesting()
	
	var body: some View {
			VStack {
				if(loc == "Arizona") {
					List(fetch.arizona.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "California") {
					List(fetch.california.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Delaware") {
					List(fetch.delaware.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Florida") {
					List(fetch.florida.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Massachusetts") {
					List(fetch.massachusetts.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Nevada") {
					List(fetch.nevada.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "New Jersey") {
					List(fetch.delaware.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "New York") {
					List(fetch.delaware.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Delaware") {
					List(fetch.delaware.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Pennsylvania") {
					List(fetch.delaware.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Texas") {
					List(fetch.texas.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Utah") {
					List(fetch.utah.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
				else if(loc == "Washington") {
					List(fetch.washington.self) { item in
						VStack(alignment:.leading){
							Spacer()
							Text("Name")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.name)
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Spacer()
							Text("Transportation")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(item.transportation)
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
							Spacer()
						}
					}.listStyle(GroupedListStyle())
						.environment(\.horizontalSizeClass, .regular)
					//Banner()
				}
		}
	}
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}

class getTesting : ObservableObject {
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
		//id = try values.decodeIfPresent(Int.self, forKey: .id)
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

struct Physical_address : Codable {
	let id : String!
	let location_id : String!
	let address_1 : String!
	let city : String!
	let region : String!
	let state_province : String!
	let postal_code : String!
	let country : String!

	enum CodingKeys: String, CodingKey {
		case id = "id"
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
		id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		address_1 = try values.decodeIfPresent(String.self, forKey: .address_1)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		region = try values.decodeIfPresent(String.self, forKey: .region)
		state_province = try values.decodeIfPresent(String.self, forKey: .state_province)
		postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}
}

struct Regular_schedule : Codable {
	let id : String!
	let location_id : String!
	let weekday : String!
	let opens_at : String!
	let closes_at : String!

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case location_id = "location_id"
		case weekday = "weekday"
		case opens_at = "opens_at"
		case closes_at = "closes_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		weekday = try values.decodeIfPresent(String.self, forKey: .weekday)
		opens_at = try values.decodeIfPresent(String.self, forKey: .opens_at)
		closes_at = try values.decodeIfPresent(String.self, forKey: .closes_at)
	}
}

struct Phones : Codable {
	let id : String!
	let location_id : String!
	let number : String!
	let ext : String!
	let type : String!
	let language : String!
	let description : String!

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case location_id = "location_id"
		case number = "number"
		case ext = "extension"
		case type = "type"
		case language = "language"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
		number = try values.decodeIfPresent(String.self, forKey: .number)
		ext = try values.decodeIfPresent(String.self, forKey: .ext)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}
}
