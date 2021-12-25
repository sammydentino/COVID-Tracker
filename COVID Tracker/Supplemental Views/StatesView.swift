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
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -10).padding(.bottom, 5).background(Color.white)
            Picker("", selection: $tab) {
                Text("Cases").tag(0)
                Text("Vaccinations").tag(1)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal).padding(.bottom).background(Color.white)
            ZStack {
                if tab == 0 {
                    List {
                        ForEach(Array(zip(fetch.states.filter {
                            self.searchQuery.isEmpty ? true : "\($0)".lowercased().contains(self.searchQuery.lowercased())
                        }.indices, fetch.states.filter {
                            self.searchQuery.isEmpty ? true : "\($0)".lowercased().contains(self.searchQuery.lowercased())
                        })), id: \.0) { index, item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text("#\(index + 1) ")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.secondary)
                                    Text("\(item.state)")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text("\(item.active.withCommas())")
                                        .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                        .font(.subheadline)
                                        .bold()
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
                    }.listStyle(PlainListStyle())
                } else {
                    List {
                        ForEach(Array(zip(fetch.statevaccinations.filter({ searchQuery.isEmpty ? true : $0.name.lowercased().contains(searchQuery.lowercased()) }).indices, fetch.statevaccinations.filter({ searchQuery.isEmpty ? true : $0.name.lowercased().contains(searchQuery.lowercased()) }))), id: \.0) { index, item in
                            Button(action: {
                                self.selectedstate = item
                                self.showingDetail = true
                            }) {
                                HStack {
                                    Text("#\(index + 1) ")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.secondary)
                                    Text("\(item.name)")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text("\(item.completedVaccination.withCommas())")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.orange)
                                    Text("→")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.secondary)
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                StateVaccinationDetailView(item: self.selectedstate ?? item)
                            }
                        }
                    }.listStyle(PlainListStyle())
                }
            }
		}
	}
}
