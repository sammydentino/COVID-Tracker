//
//  VaccinationView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 3/24/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI
import PartialSheet

struct VaccinationView: View {
    @State private var searchQuery: String = ""
    let fetch: getAll!
    @State private var showingDetail = false
    @EnvironmentObject var partialSheet : PartialSheetManager
    @State private var selected: Vaccination?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 5).padding(.top, -10).padding(.bottom, 5)
            List {
                Section(header: Text("   Sorted by Most Vaccinations").font(.headline).bold().padding(.vertical, 5).padding(.top, 10).fixCase()) {
                    ForEach(fetch.vaccinations.filter({ searchQuery.isEmpty ? true : $0.country.lowercased().contains(searchQuery.lowercased()) })) { item in
                        Button(action: {
                            self.selected = item
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
                        }.partialSheet(isPresented: self.$showingDetail) {
                            VaccinationDetailView(item: self.selected ?? item)
                        }
                    }
                }
            }.fixList()
        }
    }
}

