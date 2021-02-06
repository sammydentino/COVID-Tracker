//
//  DocumentationView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 4/21/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct SourcesView: View {
    var body: some View {
		VStack(spacing: 0) {
			List {
				Section(header: Text("\nInformation")
					.font(.headline)
					.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882)),
						footer: Text("github.com/CSSEGISandData/COVID-19\n")
							.font(.system(size: 12))
							.foregroundColor(.gray).bold()) {
					VStack(alignment: .leading) {
						Spacer()
                        Text("This application utilizes the data repository for the 2019 Novel Coronavirus Visual Dashboard operated by the Johns Hopkins University Center for Systems Science and Engineering and Applied Physics Lab (JHU CSSE & APL).")
							.bold()
						Spacer()
						}.font(.subheadline)
				}
				Section(header: Text("Data Sources")
					.font(.headline)
					.foregroundColor(.purple)) {
					Group {
						Text("World Health Organization (WHO)")
							.bold()
						Text("DXY.cn Pneumonia 2020")
							.bold()
						Text("BNO News")
							.bold()
						Text("National Health Commission of China (NHC)")
							.bold()
						Text("China CDC (CCDC)")
							.bold()
						Text("Hong Kong Department of Health")
							.bold()
						Text("Macau Government")
							.bold()
						Text("Taiwan CDC")
							.bold()
						Text("US CDC")
							.bold()
					}.font(.subheadline)
					Group {
						Text("Government of Canada")
							.bold()
						Text("Australia Government Department of Health")
							.bold()
						Text("European Center Disease Control (ECDC)")
							.bold()
						Text("Ministry of Health Singapore (MOH)")
							.bold()
						Text("Italy Ministry of Health")
							.bold()
						Text("1Point3Arces")
							.bold()
						Text("WorldoMeters")
							.bold()
						Text("COVID Tracking Project")
							.bold()
						Text("French Government")
							.bold()
					}.font(.subheadline)
				}
			}.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .compact)
		}
    }
}
