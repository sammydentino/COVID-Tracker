//
//  TotalView.swift
//  COVIDradar
//
//  Created by Sammy Dentino on 4/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import BetterSafariView

struct TotalView: View {
    let fetch: getAll!
    @State private var showingDetail = false
    @State private var showingInfo = false
    
    var body: some View {
        List {
            Group {
                VStack {
                    Spacer()
                    HStack {
                        Text("Total")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.cases.withCommas())")
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
                        Text("\(fetch.global.active.withCommas())")
                            .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                    HStack{
                        Text("Critical")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.critical.withCommas())")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                    }
                    Spacer()
                    HStack {
                        Text("New Today")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.todayCases.withCommas())")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
                    }
                    Spacer()
                }
                /*Button(action: {
                 self.showingDetail.toggle()
                 }) {
                 HStack {
                 Text("View Source Information")
                 .font(.subheadline)
                 .bold()
                 .foregroundColor(.secondary)
                 Spacer()
                 Text("→")
                 .font(.subheadline)
                 .bold()
                 .foregroundColor(.secondary)
                 }.padding(.vertical, -3)
                 }.sheet(isPresented: $showingDetail) {
                 NavigationView {
                 SourcesView().navigationBarTitle("Sources")
                 }
                 }*/
            }.makeColoredSection(str: "Cases", color: Color(red: 0, green: 0.6588, blue: 0.9882))
            Group {
                VStack {
                    Spacer()
                    HStack {
                        Text("Total")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.deaths.withCommas())")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                    HStack {
                        Text("New Today")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.todayDeaths.withCommas())")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
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
                        Text("\(fetch.global.recovered.withCommas())")
                            .foregroundColor(.green)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                    HStack {
                        Text("New Today")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.todayRecovered.withCommas())")
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
                    /*HStack {
                        Text("Affected Areas")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.affectedCountries.withCommas())")
                            .foregroundColor(.purple)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()*/
                    HStack {
                        Text("Fatality Rate")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.deathRate, specifier: "%.2f")%")
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
                        Text("\(fetch.global.activeVsConf, specifier: "%.2f")%")
                            .foregroundColor(.purple)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                    HStack {
                        Text("Recovered Cases")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\((100 - fetch.global.activeVsConf), specifier: "%.2f")%")
                            .foregroundColor(.purple)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                }
            }.makeColoredSection(str: "Statistics", color: .purple)
            //MoPubBannerView(adUnitID: "6e01b35977dc4214b8f8cf847493a17a", adSize: CGSize(width: 320, height: 50))
            VStack {
                Spacer()
                HStack {
                    Text("Doses Adminstered")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(fetch.worldvaccinations.data.last?.totalVaccinations ?? 0)")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.orange)
                }
                Spacer()
                HStack {
                    Text("People Vaccinated")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(fetch.worldvaccinations.data.last?.peopleVaccinated ?? 0)")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.orange)
                }
                Spacer()
                HStack {
                    Text("People Fully Vaccinated")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(fetch.worldvaccinations.data.last?.peopleFullyVaccinated ?? 0)")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.orange)
                }
                Divider().padding(.vertical, 5)
                Button(action: {
                    self.showingInfo = true
                }) {
                    HStack {
                        Text("Getting Vaccinated in the United States?").font(.subheadline).bold().foregroundColor(.orange)
                        Spacer()
                        Image(systemName: "info.circle").font(.system(size: 15, weight: .bold)).foregroundColor(.orange)
                    }
                }.buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showingInfo) {
                    SafariView(
                        url: URL(string: "https://www.wsj.com/articles/how-to-get-a-covid-19-vaccine-a-state-by-state-guide-11611703769")!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: true,
                            barCollapsingEnabled: false
                        )
                    )
                    .preferredBarAccentColor(.white)
                    .preferredControlAccentColor(.accentColor)
                    .dismissButtonStyle(.close)
                }
                Spacer()
            }.makeColoredSectionBoth(str: "Vaccinations", color: Color(.orange))
            /*Group {
                VStack {
                    Spacer()
                    HStack {
                        Text("Total")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text("\(fetch.global.tests.withCommas())")
                            .foregroundColor(.orange)
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                }
            }.makeColoredSection(str: "Tests", color: .orange)*/
        }.fixList()
    }
}
