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
    let fetch: getCounties!
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 2.5).padding(.top, -5).padding(.bottom, 5)
			List {
                if fetch.counties.filter { item in
                    item.countyName.lowercased() == self.searchQuery.lowercased()
                }.count != 0 {
                    Section(header: Text("\nSearch Results").font(.subheadline).bold()) {
                        ForEach(fetch.counties.filter { item in
                            item.countyName.lowercased() == self.searchQuery.lowercased()
                        }) { item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     DetailView3(county: item).navigationBarTitle(item.countyName)
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
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     DetailView3(county: item).navigationBarTitle(item.countyName)
                                }
                            }
                        }
                    }
                } else {
                    Section(header: Text("\nTop 10 Most Affected").font(.subheadline).bold()) {
                        ForEach(fetch.top10) { item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     DetailView3(county: item).navigationBarTitle(item.countyName)
                                }
                            }
                        }
                    }
                }
			}.listStyle(GroupedListStyle())
		}
	}
}

struct DetailView3: View {
	let county : County!
	
	var body: some View {
		VStack(spacing: 0) {
			CountyMapView(lat: county.latitude, long: county.longitude).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
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
							if(county.new == 0) {
								Text("N/A")
									.font(.subheadline)
									.bold()
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
							} else {
								Text("\(county.new.withCommas())")
									.font(.subheadline)
									.bold()
									.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
							}
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
							Text("\(county.deaths.withCommas())")
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
							if(county.newDeaths == 0) {
								Text("N/A")
									.font(.subheadline)
									.bold()
									.foregroundColor(.red)
							} else {
								Text("\(county.newDeaths.withCommas())")
									.font(.subheadline)
									.bold()
									.foregroundColor(.red)
							}
						}
						Spacer()
					}
				}
				Section(header: Text("Statistics")
					.font(.headline)
					.foregroundColor(.green)) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Fatality Rate")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(county.fatalityRate)")
                                .foregroundColor(.green)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
				}
			}.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .compact)
		}
	}
}

class getCounties: ObservableObject {
	@Published var counties: [County]!
	@Published var top10: [County]!
	
	init() {
        DispatchQueue.main.async {
            self.loadCounties()
            self.counties = self.counties.sorted(by: {
                $0.countyName < $1.countyName
            })
            self.top10 = self.top10.sorted(by: {
                $0.confirmed > $1.confirmed
            })
            self.top10 = Array(self.top10.prefix(10))
        }
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
	let countyName : String!
	let stateName : String!
	let confirmed : Int!
	let new : Int!
	let deaths : Int!
	let newDeaths : Int!
	let fatalityRate : String!
	let latitude : Double!
	let longitude : Double!
	let update : String!

	enum CodingKeys: String, CodingKey {
		case countyName = "county_name"
		case stateName = "state_name"
		case confirmed = "confirmed"
		case new = "new"
		case deaths = "death"
		case newDeaths = "new_death"
		case fatalityRate = "fatality_rate"
		case latitude = "latitude"
		case longitude = "longitude"
		case update = "last_update"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		countyName = try values.decodeIfPresent(String.self, forKey: .countyName) ?? "N/A"
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName) ?? "N/A"
		confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
		new = try values.decodeIfPresent(Int.self, forKey: .new) ?? 0
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
		newDeaths = try values.decodeIfPresent(Int.self, forKey: .newDeaths) ?? 0
		fatalityRate = try values.decodeIfPresent(String.self, forKey: .fatalityRate) ?? "N/A"
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
		update = try values.decodeIfPresent(String.self, forKey: .update) ?? "N/A"
	}
}
