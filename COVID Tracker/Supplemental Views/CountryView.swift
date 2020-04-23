//
//  CountryView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct DetailView: View {
	let country : Country
	
	var body: some View {
		VStack {
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
							Text(country.cases.withCommas())
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
							Text(country.active.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
						}
						Spacer()
						HStack {
							Text("Critical")
								.font(.subheadline)
								.bold()
							Spacer()
							Text(country.critical.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
							
						}
						Spacer()
						HStack {
							Text("New Today").font(.subheadline).bold()
							Spacer()
							Text(country.todayCases.withCommas())
								.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
								.font(.subheadline)
								.bold()
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
							Text(country.deaths.withCommas())
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
							Text(country.todayDeaths.withCommas())
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
					HStack {
						Text("Total")
							.font(.subheadline)
							.bold()
						Spacer()
						Text(country.recovered.withCommas())
							.foregroundColor(.orange)
							.font(.subheadline)
							.bold()
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
						Text(country.tests.withCommas())
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

struct CountryView: View {
	@State private var searchQuery: String = ""
	@ObservedObject var fetch = getData()
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			SearchBar(text: self.$searchQuery,
					  placeholder: "Search for a Country").padding(8)
			List {
				Section(header: Text("\nSorted by Most Cases")
					.font(.system(size: 12))
					.foregroundColor(.gray).bold()) {
					ForEach(fetch.countries.filter {
						self.searchQuery.isEmpty ?
							true :
							"\($0)".contains(self.searchQuery)
					}, id: \.country) { item in
						NavigationLink(destination: DetailView(country: item).navigationBarTitle(item.country)) {
							Text(item.country)
								.font(.subheadline)
								.bold()
								.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
						}
					}
				}
			}.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
		}
	}
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
