//
//  TotalView.swift
//  COVIDradar
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct TotalView: View {
	@ObservedObject var fetch = getData()

    var body: some View {
		VStack (alignment: .center, spacing: 0) {
			List {
				Section(header: Text("\nCases")
					.font(.headline).foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882)),
						footer: Text("Data is sourced from JHU CSSE. For more detailed information, please view the sources tab.")
							.font(.system(size: 12))
							.foregroundColor(.gray).bold()) {
					VStack {
						Spacer()
						HStack {
							Text("Total")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.global.cases.withCommas())
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
							Text(fetch.global.active.withCommas())
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
							Text(fetch.global.critical.withCommas())
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
							Text(fetch.global.todayCases.withCommas())
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
							Text(fetch.global.deaths.withCommas())
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
							Text(fetch.global.todayDeaths.withCommas())
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
							Text(fetch.global.recovered.withCommas())
								.foregroundColor(.orange)
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("New Today")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(fetch.extras.global.newRecovered.withCommas())
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
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.tests.withCommas())
							.foregroundColor(.green)
							.font(.subheadline)
							.bold()
					}
				}
				Section(header: Text("Affected Areas")
					.font(.headline)
					.foregroundColor(.purple)) {
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(fetch.global.affectedCountries.withCommas())
							.foregroundColor(.purple)
							.font(.subheadline)
							.bold()
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
		}
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        TotalView()
    }
}
