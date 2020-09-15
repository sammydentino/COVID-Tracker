//
//  TimelineView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct TimelineView : View {
	@State private var selected = 0
    let fetch: getTimeline!
    @State private var showingDetail = false
	var body: some View {
		VStack {
			Picker("", selection: $selected) {
				Text("Cases").tag(0)
				Text("Deaths").tag(1)
				Text("Recovered").tag(2)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 12.5).padding(.top, -2.5)
			if selected == 0 {
                LineView(data: self.fetch.cases.reversed(), title: "Cases", legend: "Latest: \(Int(self.fetch.cases[0]).withCommas())").padding().padding(.bottom, 100)
			} else if selected == 1 {
				LineView(data: self.fetch.deaths.reversed(), title: "Deaths", legend: "Latest: \(Int(self.fetch.deaths[0]).withCommas())").padding().padding(.bottom, 100)
			} else if selected == 2 {
                LineView(data: self.fetch.recovered.reversed(), title: "Recovered", legend: "Latest: \(Int(self.fetch.recovered[0]).withCommas())").padding().padding(.bottom, 100)
			}
		}
	}
}

class getTimeline: ObservableObject {
	@Published var timeline : [Timeline]!
	@Published var cases = [Double]()
	@Published var deaths = [Double]()
	@Published var recovered = [Double]()
	
	init() {
        DispatchQueue.main.async {
            self.loadTimeline()
            for item in self.timeline {
                self.cases.append(item.cases)
                self.deaths.append(item.deaths)
                self.recovered.append(item.recovered)
            }
        }
		//cases = Array(cases[0..<30])
		//deaths = Array(deaths[0..<30])
		//recovered = Array(recovered[0..<30])
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
	var deaths: Double!
	var recovered: Double!
    var dateFormatter = DateFormatter()
    var dateFormatterPrint = DateFormatter()
    var datein: Date!
    var dateout: String!

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
		deaths = Double(totalDeaths)
		recovered = Double(totalRecovered)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterPrint.dateFormat = "MMMM dd"
        datein = dateFormatter.date(from: update)
        dateout = dateFormatterPrint.string(from: datein ?? Date())
        //date = dateFormatter.string(from: Date(timeIntervalSince1970: update))
	}
}
