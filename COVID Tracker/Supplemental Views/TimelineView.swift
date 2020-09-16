//
//  TimelineView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct TimelineView : View {
	@State private var selected = 0
    let fetch: getAll!
    let cases: Int!
    let deaths: Int!
    let recovered: Int!
    @State private var showingDetail = false
	var body: some View {
		VStack {
            Picker("", selection: $selected) {
                Text("Cases").tag(0)
                Text("Deaths").tag(1)
                Text("Recovered").tag(2)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 15)
			if selected == 0 {
                LineView(data: self.fetch.cases.reversed(), title: "Cases", legend: "Latest: \(cases.withCommas())", valueSpecifier: "%.0f").padding(.horizontal).padding(.bottom, 75).padding(.horizontal, 2.5)
			} else if selected == 1 {
                LineView(data: self.fetch.deaths.reversed(), title: "Deaths", legend: "Latest: \(deaths.withCommas())", valueSpecifier: "%.0f").padding(.horizontal).padding(.bottom, 75).padding(.horizontal, 2.5)
			} else if selected == 2 {
                LineView(data: self.fetch.recovered.reversed(), title: "Recovered", legend: "Latest: \(recovered.withCommas())", valueSpecifier: "%.0f").padding(.horizontal).padding(.bottom, 75).padding(.horizontal, 2.5)
			}
        }
	}
}
