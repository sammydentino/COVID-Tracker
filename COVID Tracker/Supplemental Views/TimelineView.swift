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
    @State private var showingDetail = false
	var body: some View {
		VStack {
			if selected == 0 {
                LineView(data: self.fetch.cases.reversed(), title: "Cases", legend: "Latest: \(Int(self.fetch.cases[0]).withCommas())", valueSpecifier: "%.0f").padding().padding(.bottom, 75)
			} else if selected == 1 {
				LineView(data: self.fetch.deaths.reversed(), title: "Deaths", legend: "Latest: \(Int(self.fetch.deaths[0]).withCommas())", valueSpecifier: "%.0f").padding().padding(.bottom, 75)
			} else if selected == 2 {
                LineView(data: self.fetch.recovered.reversed(), title: "Recovered", legend: "Latest: \(Int(self.fetch.recovered[0]).withCommas())", valueSpecifier: "%.0f").padding().padding(.bottom, 75)
			}
            Picker("", selection: $selected) {
                Text("Cases").tag(0)
                Text("Deaths").tag(1)
                Text("Recovered").tag(2)
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 30).padding(.vertical, 2.5)
		}
	}
}
