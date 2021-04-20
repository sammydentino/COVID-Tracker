//
//  StatesView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/17/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct StatesView: View {
	@State private var searchQuery: String = ""
    let fetch: getAll!
	@State private var showingDetail = false
    @State private var selectedstate: StateVaccination?
    @State private var tab = 0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -10).padding(.bottom, 5)
            Picker("", selection: $tab) {
                Text("Cases").tag(0)
                Text("Vaccinations").tag(1)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal).padding(.bottom)
            ZStack {
                if tab == 0 {
                    List {
                        Section(header: Text("   Sorted by Most Active Cases").font(.headline).bold().padding(.vertical, 5).padding(.top, 10).fixCase(), footer: Text("\n\n\n")) {
                            ForEach(fetch.states.filter {
                                self.searchQuery.isEmpty ? true : "\($0)".lowercased().contains(self.searchQuery.lowercased())
                            }) { item in
                                Button(action: {
                                    self.showingDetail.toggle()
                                }) {
                                    HStack {
                                        Text("\(item.state)")
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
                                         StatesDetailView(state: item).navigationBarTitle(item.state)
                                    }
                                }
                            }
                        }
                    }.fixList()
                } else {
                    List {
                        Section(header: Text("   Sorted by Most Vaccinations").font(.headline).bold().padding(.vertical, 5).padding(.top, 10).fixCase(), footer: Text("\n\n\n")) {
                            ForEach(fetch.statevaccinations.filter({ searchQuery.isEmpty ? true : $0.name.lowercased().contains(searchQuery.lowercased()) })) { item in
                                Button(action: {
                                    self.selectedstate = item
                                    self.showingDetail = true
                                }) {
                                    HStack {
                                        Text("\(item.name)")
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
                                    StateVaccinationDetailView(item: self.selectedstate ?? item)
                                }
                            }
                        }
                    }.fixList()
                }
            }
		}
	}
}
