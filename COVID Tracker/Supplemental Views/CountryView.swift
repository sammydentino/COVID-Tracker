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
    @State private var selected: Vaccination?
    @State private var tab = 0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -10).padding(.bottom, 5).background(Color.white)
            Picker("", selection: $tab) {
                Text("Cases").tag(0)
                Text("Vaccinations").tag(1)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal).padding(.bottom).background(Color.white)
            ZStack {
                if tab == 0 {
                    List {
                        Section(header: Text("   Sorted by Most Active Cases").font(.headline).bold().padding(.vertical, 5).padding(.top, 10).fixCase(), footer: Text("\n\n\n")) {
                            ForEach(fetch.countries.filter({ searchQuery.isEmpty ? true : $0.country.lowercased().contains(searchQuery.lowercased()) })) { item in
                                Button(action: {
                                    self.showingDetail.toggle()
                                    /*vaccinations = fetch.vaccinations.filter({
                                        $0.country.lowercased() == item.country.lowercased()
                                    })[0]
                                    print(vaccinations?.country ?? "N/A")*/
                                }) {
                                    HStack {
                                        Text("\(item.country)")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("→")
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
                    }.fixList()
                } else {
                    List {
                        Section(header: Text("   Sorted by Most Vaccinations").font(.headline).bold().padding(.vertical, 5).padding(.top, 10).fixCase(), footer: Text("\n\n\n")) {
                            ForEach(fetch.vaccinations.filter({ searchQuery.isEmpty ? true : $0.name!.lowercased().contains(searchQuery.lowercased()) })) { item in
                                Button(action: {
                                    self.selected = item
                                    self.showingDetail = true
                                }) {
                                    HStack {
                                        Text("\(item.name!)")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("→")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(.secondary)
                                    }
                                }.sheet(isPresented: self.$showingDetail) {
                                    VaccinationDetailView(item: self.selected ?? item)
                                }
                            }
                        }
                    }.fixList()
                }
            }
		}
	}
}
