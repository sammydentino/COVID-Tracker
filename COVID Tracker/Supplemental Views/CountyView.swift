//
//  CountyView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/10/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct CountyView: View {
	@State private var searchQuery: String = ""
	@State private var showingDetail = false
    let fetch: getCounties!
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 2.5).padding(.top, -10).padding(.bottom, 5)
			List {
                if fetch.counties.filter { item in
                    item.countyName.lowercased() == self.searchQuery.lowercased()
                }.count != 0 {
                    Section(header: Text("\nSearch Results").font(.subheadline).bold()) {
                        ForEach(fetch.counties.filter { item in
                            item.countyName.lowercased() == self.searchQuery.lowercased()
                        }) { item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     CountyDetailView(county: item).navigationBarTitle(item.countyName)
                                }
                            }
                        }
                    }
                    Section(header: Text("Top 10 Most Affected").font(.subheadline).bold()) {
                        ForEach(fetch.top10) { item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     CountyDetailView(county: item).navigationBarTitle(item.countyName)
                                }
                            }
                        }
                    }
                } else {
                    Section(header: Text("\nTop 10 Most Affected").font(.subheadline).bold()) {
                        ForEach(fetch.top10) { item in
                            Button(action: {
                                self.showingDetail.toggle()
                            }) {
                                HStack {
                                    Text(item.countyName).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                                    Spacer()
                                    Text(item.stateName).foregroundColor(.gray).font(.subheadline).bold().padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 0))
                                }
                            }.sheet(isPresented: self.$showingDetail) {
                                NavigationView {
                                     CountyDetailView(county: item).navigationBarTitle(item.countyName)
                                }
                            }
                        }
                    }
                }
			}.listStyle(GroupedListStyle())
		}
	}
}
