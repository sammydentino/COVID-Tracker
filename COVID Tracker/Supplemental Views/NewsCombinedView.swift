//
//  NewsCombinedView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/14/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct NewsCombinedView : View {
	@State private var selected = 0
	
	var body: some View {
		VStack {
			Picker("", selection: $selected) {
				Text("Articles").tag(0)
				Text("Tweets").tag(1)
			}.pickerStyle(SegmentedPickerStyle()).padding(.leading, 17).padding(.trailing, 17)
			if selected == 0 {
				NewsView().navigationBarTitle("Articles")
			} else if selected == 1 {
				List {
					Text("In Progress")
				}.navigationBarTitle("Tweets")
				//TwitterView().navigationBarTitle("Tweets")
			}
		}
	}
}
