//
//  VaccinationView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 3/24/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct StateVaccinationDetailView: View {
    let item: StateVaccination!
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Doses Administered")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(item.dosesAdministered)")
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
                            Text("\(item.peopleVaccinated)")
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
                            Text("\(item.completedVaccination)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        HStack {
                            Text("One Dose (J&J)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(item.completedOneDoseVaccination ?? 0)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.orange)
                        }
                        Spacer()
                    }.makeNewLineColoredSection(str: "Vaccinations", color: Color.orange)
                    if item.cdcDosesDistributed != nil {
                        VStack {
                            Spacer()
                            HStack {
                                Text("Doses Distributed by CDC")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\(item.cdcDosesDistributed ?? 0)")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.purple)
                            }
                            Spacer()
                        }.makeColoredSection(str: "Distribution", color: Color.purple)
                        VStack {
                            Spacer()
                            HStack {
                                Text("Doses Not Administered")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\((item.cdcDosesDistributed ?? 0) - item.dosesAdministered)")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.green)
                            }
                            Spacer()
                        }.makeColoredSection(str: "Availability", color: Color.green)
                    }
                }.fixList()
            }.navigationBarTitle(item.name)
        }
    }
}
