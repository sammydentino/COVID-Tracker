//
//  TotalView.swift
//  COVIDradar
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

// isn't used at the moment

struct TotalView: View {
    let fetch: getAll!
	@State private var showingDetail = false
	
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
                            Text(fetch.global.cases!.withCommas())
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
                            Text(fetch.global.active!.withCommas())
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
                            Text(fetch.global.critical!.withCommas())
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
                            Text(fetch.global.todayCases!.withCommas())
								.font(.subheadline)
								.bold()
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
						}
						Spacer()
					}
					Button(action: {
						self.showingDetail.toggle()
					}) {
                        HStack {
                            Text("View Source Information")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("→")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.secondary)
                        }
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
                            Text(fetch.global.deaths!.withCommas())
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
                            Text(fetch.global.todayDeaths!.withCommas())
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
                            Text(fetch.global.recovered!.withCommas())
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
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text(fetch.global.tests!.withCommas())
                                .foregroundColor(.green)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
				}
				Section(header: Text("Affected Areas")
					.font(.headline)
					.foregroundColor(.purple)) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text(fetch.global.affectedCountries!.withCommas())
                                .foregroundColor(.purple)
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

class getAll : ObservableObject {
    @Published var global : Global!
    @Published var extras : Welcome!
    
    init() {
        loadAll()
        loadExtras()
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
    let cases : Int?
    let todayCases : Int?
    let deaths : Int?
    let todayDeaths : Int?
    let recovered : Int?
    let todayRecovered : Int?
    let active : Int?
    let critical : Int?
    let casesPerOneMillion : Int?
    let deathsPerOneMillion : Double?
    let tests : Int?
    let testsPerOneMillion : Double?
    let population : Int?
    let oneCasePerPeople : Int?
    let oneDeathPerPeople : Int?
    let oneTestPerPeople : Int?
    let activePerOneMillion : Double?
    let recoveredPerOneMillion : Double?
    let criticalPerOneMillion : Double?
    let affectedCountries : Int?

    enum CodingKeys: String, CodingKey {

        case updated = "updated"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case todayRecovered = "todayRecovered"
        case active = "active"
        case critical = "critical"
        case casesPerOneMillion = "casesPerOneMillion"
        case deathsPerOneMillion = "deathsPerOneMillion"
        case tests = "tests"
        case testsPerOneMillion = "testsPerOneMillion"
        case population = "population"
        case oneCasePerPeople = "oneCasePerPeople"
        case oneDeathPerPeople = "oneDeathPerPeople"
        case oneTestPerPeople = "oneTestPerPeople"
        case activePerOneMillion = "activePerOneMillion"
        case recoveredPerOneMillion = "recoveredPerOneMillion"
        case criticalPerOneMillion = "criticalPerOneMillion"
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
        todayRecovered = try values.decodeIfPresent(Int.self, forKey: .todayRecovered)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        critical = try values.decodeIfPresent(Int.self, forKey: .critical)
        casesPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .casesPerOneMillion)
        deathsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .deathsPerOneMillion)
        tests = try values.decodeIfPresent(Int.self, forKey: .tests)
        testsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .testsPerOneMillion)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        oneCasePerPeople = try values.decodeIfPresent(Int.self, forKey: .oneCasePerPeople)
        oneDeathPerPeople = try values.decodeIfPresent(Int.self, forKey: .oneDeathPerPeople)
        oneTestPerPeople = try values.decodeIfPresent(Int.self, forKey: .oneTestPerPeople)
        activePerOneMillion = try values.decodeIfPresent(Double.self, forKey: .activePerOneMillion)
        recoveredPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .recoveredPerOneMillion)
        criticalPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .criticalPerOneMillion)
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
        newRecovered = try values.decodeIfPresent(Int.self, forKey: .newRecovered) ?? 0
        totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered)
    }
}
