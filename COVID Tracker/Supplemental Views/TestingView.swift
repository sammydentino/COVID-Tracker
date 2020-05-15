//
//  TestingView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/23/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
	@State private var showingDetail = false
	let item: Testing
	
	var body: some View {
		Button(action: {
			self.showingDetail.toggle()
		}) {
			Text(item.name)
				.font(.subheadline)
				.bold()
				.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
		}.sheet(isPresented: self.$showingDetail) {
			NavigationView {
				TestDetail(item: self.item).navigationBarTitle(self.item.name)
			}
		}
	}
}

struct TestingView: View {
    @State private var searchQuery: String = ""
	@ObservedObject private var fetch = getTesting()
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			SearchBar(text: self.$searchQuery, placeholder: "Case Sensitive").padding(.leading, 8).padding(.trailing, 8)
			List {
				Group {
					Section(header: Text("Arizona").font(.subheadline)
					.bold()) {
						ForEach(fetch.arizona.filter {
							self.searchQuery.isEmpty ?
								true :
								"\($0)".contains(self.searchQuery)
						}, id: \.name) { item in
							ButtonView(item: item)
						}
					}
					Section(header: Text("California").font(.subheadline)
					.bold()) {
						ForEach(fetch.california.filter {
							self.searchQuery.isEmpty ?
								true :
								"\($0)".contains(self.searchQuery)
						}, id: \.name) { item in
							ButtonView(item: item)
						}
					}
					Section(header: Text("Delaware").font(.subheadline)
					.bold()) {
						ForEach(fetch.delaware.filter {
							self.searchQuery.isEmpty ?
								true :
								"\($0)".contains(self.searchQuery)
						}, id: \.name) { item in
							ButtonView(item: item)
						}
					}
				}
				Section(header: Text("Florida").font(.subheadline)
				.bold()) {
					ForEach(fetch.florida.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Massachusetts").font(.subheadline)
				.bold()) {
					ForEach(fetch.massachusetts.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Nevada").font(.subheadline)
				.bold()) {
					ForEach(fetch.nevada.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("New Jersey")) {
					ForEach(fetch.newJersey.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("New York")) {
					ForEach(fetch.newYork.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Pennsylvania")) {
					ForEach(fetch.pennsylvania.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Texas")) {
					ForEach(fetch.texas.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Utah")) {
					ForEach(fetch.utah.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
				Section(header: Text("Washington")) {
					ForEach(fetch.washington.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.name) { item in
						ButtonView(item: item)
					}
				}
			}.listStyle(GroupedListStyle())
		}
	}
}

struct TestDetail: View {
	let item: Testing!
	
	var body: some View {
		VStack {
			List {
				Section(header: Text("Name")
					.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
					.font(.subheadline)
					.bold()) {
					VStack (alignment:.leading){
						Spacer()
						Text("\(item.name)")
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
				Section(header: Text("Address")
					.foregroundColor(.red)
					.font(.subheadline)
					.bold()) {
					VStack (alignment:.leading){
						Spacer()
						ForEach(item.physical_address) { item in
							Text("\(item.address_1),")
								.font(.subheadline)
								.bold()
							Text("\(item.city), \(item.state_province) \(item.postal_code)")
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Phone Number")
					.foregroundColor(.green)
					.font(.subheadline)
					.bold()) {
					VStack (alignment:.leading){
						Spacer()
						ForEach(item.phones) { item in
							Text("\(item.number)")
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Description")
					.foregroundColor(.purple)
					.font(.subheadline)
					.bold()) {
					VStack (alignment:.leading){
						Spacer()
						Text("\(item.description)")
							.font(.subheadline)
							.bold()
						Spacer()
					}
				}
			}.listStyle(GroupedListStyle())
			Banner()
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
		let urlString = "https://covid-19-testing.github.io/locations/new-jersey/complete.json"
		
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
		let urlString = "https://covid-19-testing.github.io/locations/new-york/complete.json"
		
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
	var weekday : String!
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
		switch weekday {
		case "0":
			weekday = "Sunday"
		case "1":
			weekday = "Monday"
		case "2":
			weekday = "Tuesday"
		case "3":
			weekday = "Wednesday"
		case "4":
			weekday = "Thursday"
		case "5":
			weekday = "Friday"
		case "6":
			weekday = "Saturday"
		default:
			weekday = "N/A"
		}
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
