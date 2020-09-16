//
//  CountryView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct CountryView: View {
	@State private var searchQuery: String = ""
    let fetch: getAll!
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -11.5)
			List {
				Section(header: Text(" Sorted by Most Cases").font(.subheadline).bold().padding(.vertical, 10)) {
                    ForEach(fetch.countries.filter({ searchQuery.isEmpty ? true : $0.country.lowercased().contains(searchQuery.lowercased()) })) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
                            HStack {
                                Text(" \(item.country)")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("→ ")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.secondary)
                            }
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								CountryDetailView(country: item).navigationBarTitle(item.country)
							}
						}
					}
				}
			}
		}
	}
}
