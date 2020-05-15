//
//  TimelineView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct TimelineView: View {
	@ObservedObject var fetch = getTimeline()
    var body: some View {
		VStack {
			BarChartView(data: ChartData(points: fetch.cases.reversed()), title: "Cases for Last 60 Days", style: ChartStyle(backgroundColor: Color.white, accentColor: Colors.GradientNeonBlue, secondGradientColor: Colors.GradientNeonBlue, textColor: Color.black, legendTextColor: Color.primary, dropShadowColor: Color.clear), form: ChartForm.large, dropShadow: false).padding(8)
			List(fetch.timeline) { item in
				VStack {
					HStack {
						Text((item.update.prefix(10)).suffix(4))
							.font(.title)
							.bold()
						Spacer()
						VStack(alignment: .trailing, spacing: 0) {
							Text("Cases: \(item.totalCases.withCommas())")
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							Text("Deaths: \(item.totalDeaths.withCommas())")
								.foregroundColor(.red)
								.font(.subheadline)
								.bold()
							Text("Recovered: \(item.totalRecovered.withCommas())")
								.foregroundColor(.green)
								.font(.subheadline)
								.bold()
						}
					}
				}.padding(8)
			}
		}
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}

class getTimeline: ObservableObject {
	@Published var timeline : [Timeline]!
	@Published var cases = [Double]()
	
	init() {
		loadTimeline()
		for item in timeline {
			cases.append(item.cases)
		}
		cases = Array(cases[0..<60])
	}
	
	func loadTimeline() {
		let urlString = "https://covid19-api.org/api/timeline"
		if let url = URL(string: urlString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				let decoder = JSONDecoder()
				if let data = try? decoder.decode([Timeline].self, from: d) {
					timeline = data
				}
			}
		}
	}
}

struct Timeline : Codable, Identifiable {
	let id = UUID()
	var update : String!
	let totalCases : Int!
	let totalDeaths : Int!
	let totalRecovered : Int!
	var cases: Double!

	enum CodingKeys: String, CodingKey {
		case update = "last_update"
		case totalCases = "total_cases"
		case totalDeaths = "total_deaths"
		case totalRecovered = "total_recovered"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		update = try values.decodeIfPresent(String.self, forKey: .update)
		totalCases = try values.decodeIfPresent(Int.self, forKey: .totalCases) ?? 0
		totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths) ?? 0
		totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered) ?? 0
		cases = Double(totalCases)
	}
}

struct Cases : Codable, Identifiable {
	let id = UUID()
	let totalCases : Int!

	enum CodingKeys: String, CodingKey {
		case totalCases = "total_cases"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		totalCases = try values.decodeIfPresent(Int.self, forKey: .totalCases) ?? 0
	}
}

struct Deaths : Codable, Identifiable {
	let id = UUID()
	let totalDeaths : Int!

	enum CodingKeys: String, CodingKey {
		case totalDeaths = "total_deaths"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths) ?? 0
	}
}

struct Recovered : Codable, Identifiable {
	let id = UUID()
	let totalRecovered : Int!

	enum CodingKeys: String, CodingKey {
		case totalRecovered = "total_recovered"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered) ?? 0
	}
}
