//
//  CountryDetailView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    let country : Country!
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("\nCases")
                    .font(.headline)
                    .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882)).fixCase()) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.cases.withCommas())")
                                .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        HStack {
                            Text("Active")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.active.withCommas())")
                                .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if country.todayCases != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(country.todayCases.withCommas())")
                                    .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Deaths")
                    .font(.headline)
                    .foregroundColor(.red).fixCase()) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.deaths.withCommas())")
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if country.todayDeaths != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(country.todayDeaths.withCommas())")
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Recovered")
                    .font(.headline)
                    .foregroundColor(.green).fixCase()) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.recovered.withCommas())")
                                .foregroundColor(.green)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if country.todayRecovered != 0 {
                            HStack {
                                Text("Today Recovered")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(country.todayRecovered.withCommas())")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                }
                Section(header: Text("Tests")
                    .font(.headline)
                    .foregroundColor(.orange).fixCase()) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.tests.withCommas())")
                                .foregroundColor(.orange)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Statistics")
                    .font(.headline)
                    .foregroundColor(.purple).fixCase()) {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Population")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(country.population.withCommas())")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        HStack {
                            Text("Fatality Rate")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(((Double(country.deaths)) / (Double(country.cases))) * 100, specifier: "%.2f")%")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        HStack {
                            Text("Currently Active")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(((Double(country.active) / Double(country.cases))) * 100, specifier: "%.2f")%")
                                .foregroundColor(.purple)
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
