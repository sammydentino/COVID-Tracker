//
//  StatesCombinedView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/13/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct StatesCombinedView : View {
	@State private var selected = 0
	
	var body: some View {
		VStack {
			Picker("", selection: $selected) {
				Text("States").tag(0)
				Text("Counties").tag(1)
				Text("Testing").tag(2)
			}.pickerStyle(SegmentedPickerStyle()).padding(.leading, 17).padding(.trailing, 17)
			if selected == 0 {
				StatesView().navigationBarTitle("States")
			} else if selected == 1 {
				CountyView().navigationBarTitle("Counties")
			} else if selected == 2 {
				TestingView().navigationBarTitle("Testing")
			}
		}
	}
}