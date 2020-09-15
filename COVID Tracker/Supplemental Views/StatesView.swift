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
    let fetch: getStates!
	@State private var showingDetail = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
            SearchBar(text: self.$searchQuery).padding(.horizontal, 2.5).padding(.top, -10).padding(.bottom, 5)
			List {
				Section(header: Text("\nSorted by Most Cases").font(.subheadline).bold()) {
					ForEach(fetch.states.filter {
                        self.searchQuery.isEmpty ? true : "\($0)".lowercased().contains(self.searchQuery.lowercased())
					}) { item in
						Button(action: {
							self.showingDetail.toggle()
						}) {
							Text("\(item.state)")
								.font(.subheadline)
								.bold()
								.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
						}.sheet(isPresented: self.$showingDetail) {
							NavigationView {
								 StatesDetailView(state: item).navigationBarTitle(item.state)
							}
						}
					}
				}
			}.listStyle(GroupedListStyle())
		}
	}
}
