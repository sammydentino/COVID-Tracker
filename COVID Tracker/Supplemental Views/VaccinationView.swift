//
//  VaccinationView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 3/24/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct VaccinationView: View {
    @State private var searchQuery: String = ""
    let fetch: getAll!
    @State private var showingDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -10).padding(.bottom, 5)
            List {
                Section(header: Text("Sorted by Most Vaccinations").font(.subheadline).bold().padding(.vertical, 5).fixCase()) {
                    ForEach(fetch.vaccinations.filter({ searchQuery.isEmpty ? true : $0.country.lowercased().contains(searchQuery.lowercased()) })) { item in
                        Button(action: {
                            self.showingDetail = true
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
                                VStack {
                                    List {
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Text("Total Vaccinations")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.primary)
                                                Spacer()
                                                Text("\(item.data.last?.totalVaccinations ?? 0)")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.orange)
                                            }
                                            Spacer()
                                            HStack {
                                                Text("People Vaccinated")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.primary)
                                                Spacer()
                                                Text("\(item.data.last?.peopleVaccinated ?? 0)")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.orange)
                                            }
                                            Spacer()
                                            HStack {
                                                Text("People Fully Vaccinated")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.primary)
                                                Spacer()
                                                Text("\(item.data.last?.peopleFullyVaccinated ?? 0)")
                                                    .font(.subheadline)
                                                    .bold()
                                                    .foregroundColor(.orange)
                                            }
                                            Spacer()
                                        }.makeNewLineColoredSection(str: "Statistics", color: Color.orange)
                                    }.fixList()
                                }.navigationBarTitle(item.country)
                            }
                        }
                    }
                }
            }.listStyle(GroupedListStyle()).environment(\.horizontalSizeClass, .regular)
        }
    }
}

