//
//  StatesDetailView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct StatesDetailView: View {
    let state : States!
    @State private var showingDetail = false
    
    var body: some View {
        VStack {
            List {
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.cases.withCommas())")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                        }
                        Spacer()
                        HStack {
                            Text("Active")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.active.withCommas())")
                                .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if state.todayCases != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(state.todayCases.withCommas())")
                                    .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                                    .font(.subheadline)
                                    .bold()
                            }
                        }
                        Spacer()
                    }
                }.makeColoredSection(str: "Cases", color: Color(red: 0, green: 0.6588, blue: 0.9882))
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.deaths.withCommas())")
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        if state.todayDeaths != 0 {
                            HStack {
                                Text("New Today")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(state.todayDeaths.withCommas())")
                                    .foregroundColor(.red)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                }.makeColoredSection(str: "Deaths", color: .red)
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.recovered.withCommas())")
                                .foregroundColor(.green)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }.makeColoredSection(str: "Recovered", color: .green)
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Total")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.tests.withCommas())")
                                .foregroundColor(.orange)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }.makeColoredSection(str: "Tests", color: .orange)
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Population")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.population.withCommas())")
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
                            Text("\(state.deathRate, specifier: "%.2f")%")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                        HStack {
                            Text("Active Cases")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text("\(state.activeVsConf, specifier: "%.2f")%")
                                .foregroundColor(.purple)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }.makeColoredSection(str: "Statistics", color: .purple)
            }.fixList()
        }
    }
}
