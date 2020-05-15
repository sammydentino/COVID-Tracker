//
//  CountyView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/10/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import MapKit

struct CountyView: View {
	@State private var searchQuery: String = ""
	@State private var showingDetail = false
	@ObservedObject private var fetch = getCounties()
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			SearchBar(text: self.$searchQuery, placeholder: "Case Sensitive - Exact Name").padding(.leading, 8).padding(.trailing, 8)
			List {
				Section(header: Text("Search Results").font(.subheadline).bold()) {
					ForEach(fetch.counties.filter { item in
						item.county_name == self.searchQuery
					}) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							HStack {
								Text(item.county_name).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
								Spacer()
								Text(item.state_name).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
							}
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								 DetailView3(county: item).navigationBarTitle(item.county_name)
							}
						}
					}
				}
				Section(header: Text("Top 10 Most Affected").font(.subheadline).bold()) {
					ForEach(fetch.top10) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							HStack {
								Text(item.county_name).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
								Spacer()
								Text(item.state_name).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
							}
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								 DetailView3(county: item).navigationBarTitle(item.county_name)
							}
						}
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
		}
	}
}

struct DetailView3: View {
	let county : County!
	
	var body: some View {
		VStack(spacing: 0) {
			CountyMapView(lat: county.latitude, long: county.longitude).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
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
							Text("\(county.confirmed.withCommas())")
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
							Text("\(county.new.withCommas())")
								.font(.subheadline)
								.bold()
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
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
							Text("\(county.death.withCommas())")
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
							Text("\(county.new_death.withCommas())")
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
						}
						Spacer()
					}
				}
				Section(header: Text("Fatality Rate")
					.font(.headline)
					.foregroundColor(.green)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text("\(county.fatality_rate)")
							.foregroundColor(.green)
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

class getCounties: ObservableObject {
	@Published var counties: [County]!
	@Published var top10: [County]!
	
	init() {
		loadCounties()
		counties = counties.sorted(by: {
			$0.county_name < $1.county_name
		})
		top10 = top10.sorted(by: {
			$0.confirmed > $1.confirmed
		})
		top10 = Array(top10.prefix(10))
	}
	func loadCounties() {
		let urlString = "https://covid19-us-api.herokuapp.com/county"
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode(DataResponse.self, from: d) {
					counties = data.message
					top10 = data.message
				}
			}
		}
	}
}

struct CountyMapView: UIViewRepresentable {
	let lat: Double!
	let long: Double!
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
			latitude: lat ?? 0.0, longitude: long ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct DataResponse : Codable {
	let success : Bool!
	let message : [County]!

	enum CodingKeys: String, CodingKey {
		case success = "success"
		case message = "message"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		message = try values.decodeIfPresent([County].self, forKey: .message)
	}
}

struct County : Codable, Identifiable {
	let id = UUID()
	let county_name : String!
	let state_name : String!
	let confirmed : Int!
	let new : Int!
	let death : Int!
	let new_death : Int!
	let fatality_rate : String!
	let latitude : Double!
	let longitude : Double!
	let last_update : String!

	enum CodingKeys: String, CodingKey {
		case county_name = "county_name"
		case state_name = "state_name"
		case confirmed = "confirmed"
		case new = "new"
		case death = "death"
		case new_death = "new_death"
		case fatality_rate = "fatality_rate"
		case latitude = "latitude"
		case longitude = "longitude"
		case last_update = "last_update"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		county_name = try values.decodeIfPresent(String.self, forKey: .county_name) ?? "N/A"
		state_name = try values.decodeIfPresent(String.self, forKey: .state_name) ?? "N/A"
		confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
		new = try values.decodeIfPresent(Int.self, forKey: .new) ?? 0
		death = try values.decodeIfPresent(Int.self, forKey: .death) ?? 0
		new_death = try values.decodeIfPresent(Int.self, forKey: .new_death) ?? 0
		fatality_rate = try values.decodeIfPresent(String.self, forKey: .fatality_rate) ?? "N/A"
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
		last_update = try values.decodeIfPresent(String.self, forKey: .last_update) ?? "N/A"
	}
}
