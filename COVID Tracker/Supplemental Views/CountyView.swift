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
						item.county == self.searchQuery
					}) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							HStack {
								Text(item.county).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
								Spacer()
								Text(item.province).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
							}
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								 DetailView3(county: item).navigationBarTitle(item.county)
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
	let county : Result!
	
	var body: some View {
		VStack(spacing: 0) {
			MapView2(lat: county.coordinates.lat, long: county.coordinates.long)
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
							Text("\(county.stats.confirmed.withCommas())")
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
							Text("\(county.stats.deaths.withCommas())")
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
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text("\(county.stats.recovered.withCommas())")
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
	@Published var counties: [Result]!
	
	init() {
		loadCounties()
		counties = counties.sorted(by: {
			$0.county < $1.county
		})
	}
	
	func loadCounties() {
		let urlString = "https://disease.sh/v2/jhucsse/counties"
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Result].self, from: d) {
					counties = data
				}
			}
		}
	}
}

struct MapView2: UIViewRepresentable {
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

struct Result : Codable, Identifiable {
	let id = UUID()
	let country : String!
	let province : String!
	let county : String!
	let updatedAt : String?
	let stats : Stats!
	let coordinates : Coordinates!

	enum CodingKeys: String, CodingKey {
		case country = "country"
		case province = "province"
		case county = "county"
		case updatedAt = "updatedAt"
		case stats = "stats"
		case coordinates = "coordinates"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		country = try values.decodeIfPresent(String.self, forKey: .country) ?? "N/A"
		province = try values.decodeIfPresent(String.self, forKey: .province) ?? "N/A"
		county = try values.decodeIfPresent(String.self, forKey: .county) ?? "N/A"
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
		stats = try values.decodeIfPresent(Stats.self, forKey: .stats)
		coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
	}
}

struct Stats : Codable {
	let confirmed : Int!
	let deaths : Int!
	let recovered : Int!

	enum CodingKeys: String, CodingKey {
		case confirmed = "confirmed"
		case deaths = "deaths"
		case recovered = "recovered"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
		recovered = try values.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
	}
}

struct Coordinates : Codable {
	let latitude : String!
	let longitude : String!
	let lat : Double!
	let long: Double!

	enum CodingKeys: String, CodingKey {
		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		lat = Double(latitude)
		long = Double(longitude)
	}
}
