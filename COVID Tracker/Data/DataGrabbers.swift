//
//  DataGrabbers.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import Combine

class getAll : ObservableObject {
    @Published var global : Global!
    @Published var extras : Welcome!
    @Published var countries : [Country]!
    @Published var usa: Country!
    @Published var states : [States]!
    @Published var news: [News]!
    @Published var vaccinations: [Vaccination]!
    @Published var worldvaccinations: Vaccination!
    
    init() {
        if let globaltemp = Global.read(forKey: "global") {
            global = globaltemp
        } else {
            loadAll()
        }
        if let extrastemp = Welcome.read(forKey: "extras") {
            extras = extrastemp
        } else {
            loadExtras()
        }
        self.loadVaccinations()
        self.vaccinations = self.vaccinations.sorted(by: {
            $0.data.last!.peopleFullyVaccinated ?? 0 > $1.data.last!.peopleFullyVaccinated ?? 0
        })
        self.worldvaccinations = self.vaccinations.first
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadCountries()
            self.loadStates()
            self.loadNews()
            DispatchQueue.main.async {
                for item in self.countries! {
                    if item.country == "USA" {
                        self.usa = item
                    }
                }
                self.countries! = self.countries!.filter({
                    $0.country != "USA"
                })
                self.usa!.country = "United States"
                self.countries!.append(self.usa!)
                self.countries! = self.countries!.sorted(by: {
                    $0.active > $1.active
                })
                self.states = self.states.sorted(by: {
                    $0.active > $1.active
                })
            }
        }
    }
    
    func loadAll(){
        let urlString = "https://disease.sh/v2/all"
        
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(Global.self, from: d) {
                    global = data
                    global.write(withKey: "global")
                }
            }
        }
    }
    
    func loadExtras() {
        let urlString = "https://api.covid19api.com/summary"
        
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(Welcome.self, from: d) {
                    extras = data
                    extras.write(withKey: "extras")
                }
            }
        }
    }
    
    func loadCountries() {
        let urlString = "https://disease.sh/v2/countries"
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode([Country].self, from: d) {
                    DispatchQueue.main.async {
                        self.countries = data
                    }
                }
            }
        }
    }
    
    func loadStates() {
        let statesString = "https://disease.sh/v2/states"
        
        if let url = URL(string: statesString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode([States].self, from: d) {
                    DispatchQueue.main.async {
                        self.states = data
                    }
                }
            }
        }
    }
    
    func loadNews() {
        let urlString = "https://api.currentsapi.services/v1/search?keywords=Coronavirus&apiKey=I6_B_W8rEFe9iX7zxWF2La-Nc50WGQWLZWrU0hogorm-66le"

        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(Results.self, from: d) {
                    DispatchQueue.main.async {
                        self.news = data.news
                    }
                }
            }
        }
    }
    
    func loadVaccinations() {
        let urlString = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json"

        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode([Vaccination].self, from: d) {
                    vaccinations = data
                }
            }
        }
    }
}
