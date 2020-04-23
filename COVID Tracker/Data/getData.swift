//
//  getData.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/22/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import Foundation

class getData : ObservableObject {
	@Published var global : Global!
	@Published var today : String!
	@Published var extras : Welcome!
	@Published var countries : [Country]!
	@Published var states : [States]!
	
	init() {
		loadAll()
		countries = countries.sorted(by: {
			$0.cases > $1.cases
		})
	}
	func loadAll(){
		let allString = "https://corona.lmao.ninja/v2/all"
		let extrasString = "https://api.covid19api.com/summary"
		let countriesString = "https://corona.lmao.ninja/v2/countries"
		let statesString = "https://corona.lmao.ninja/v2/states"
		let decoder = JSONDecoder()
		
		if let url = URL(string: allString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				//let decoder = JSONDecoder()
				if let data = try? decoder.decode(Global.self, from: d) {
					global = data
				}
			}
		}
		if let url = URL(string: extrasString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				//let decoder = JSONDecoder()
				if let data = try? decoder.decode(Welcome.self, from: d) {
					extras = data
				}
			}
		}
		if let url = URL(string: countriesString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				//let decoder = JSONDecoder()
				if let data = try? decoder.decode([Country].self, from: d) {
					countries = data
				}
			}
		}
		if let url = URL(string: statesString) {
			if let d = try? Data(contentsOf: url) {
				// we're OK to parse!
				//let decoder = JSONDecoder()
				if let data = try? decoder.decode([States].self, from: d) {
					states = data
				}
			}
		}
		// get the current date and time
		let time = Date()

		// initialize the date formatter and set the style
		let formatter = DateFormatter()
		formatter.timeStyle = .none
		formatter.dateStyle = .long

		// get the date time String from the date object
		today = formatter.string(from: time) // October 8, 2016 at 10:48:53 PM
	}
}
