//
//  VaccinationDetailView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 3/25/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct VaccinationDetailView: View {
    let item: Vaccination!
    
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
                            Text("\(item.dosesAdministered ?? 0)")
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
                            Text("\(item.peopleVaccinated ?? 0)")
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
                            Text("\(item.completedVaccination ?? 0)")
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
                    }.makeColoredSection(str: "Vaccinations", color: Color.orange)
                }.fixList()
            }.navigationBarTitle(item.name ?? "N/A")
        }
    }
}

