//
//  CountyDetailView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct CountyDetailView: View {
    let county : County!
    
    var body: some View {
        VStack(spacing: 0) {
            CountyMapView(lat: county.latitude, long: county.longitude).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
            List {
                Section(header: Text("\nCases")
                    .font(.headline)
                    .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(county.confirmed.withCommas())")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                        }
                        Spacer()
                        if county.new != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(county.new.withCommas())")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                            }
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Deaths")
                    .font(.headline)
                    .foregroundColor(.red)) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(county.deaths.withCommas())")
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if county.newDeaths != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(county.newDeaths.withCommas())")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.red)
                            }
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Statistics")
                    .font(.headline)
                    .foregroundColor(.green)) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Fatality Rate")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(county.fatalityRate)")
                                .foregroundColor(.green)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }
            }.listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .compact)
        }
    }
}
