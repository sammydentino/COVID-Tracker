//
//  DataGrabbers.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import Combine
import CodableCSV

class getAll : ObservableObject {
    @Published var global : Global!
    @Published var extras : Welcome!
    @Published var countries : [Country]!
    @Published var usa: Country!
    @Published var states : [States]!
    @Published var news: [News]!
    @Published var vaccinations: [Vaccination]!
    @Published var worldvaccinations: GlobalVaccination!
    //@Published var vaccines: [Vaccine]!
    @Published var statevaccinations: [StateVaccination]!
    @Published var editing: Vaccination!
    
    init() {
        initAll()
        
        initCountries()
        
        initStates()
        
        loadNews()
    }
    
    func initAll() {
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
        self.loadGlobalVaccinations()
    }
    
    func initCountries() {
        self.loadCountries()
        for item in self.countries {
            if item.country == "USA" {
                self.usa = item
            }
        }
        self.countries = self.countries.filter({
            $0.country != "USA"
        })
        self.usa.country = "United States"
        self.countries.append(self.usa)
        for item in self.countries {
            if item.country == "UK" {
                self.usa = item
            }
        }
        self.countries = self.countries.filter({
            $0.country != "UK"
        })
        self.usa.country = "United Kingdom"
        self.countries.append(self.usa)
        self.countries = self.countries.sorted(by: {
            $0.active > $1.active
        })
        self.loadVaccinations()
        
    }
    
    func initStates() {
        self.loadStates()
        self.states = self.states.sorted(by: {
            $0.active > $1.active
        })
        self.loadStateVaccinations()
        self.statevaccinations = self.statevaccinations.sorted(by: {
            $0.peopleVaccinated > $1.peopleVaccinated
        })
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
    
    /*func loadVaccines() {
        let urlString = "https://github.com/owid/covid-19-data/raw/master/public/data/vaccinations/locations.csv"
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
                if let data = try? decoder.decode([Vaccine].self, from: d) {
                    vaccines = data
                }
            }
        }
    }*/
    
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
                    self.countries = data
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
                    self.states = data
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
                    self.news = data.news
                }
            }
        }
    }
    
    func loadVaccinations() {
        let urlString = "https://raw.githubusercontent.com/BloombergGraphics/covid-vaccine-tracker-data/master/data/current-global.csv"

        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
                if let data = try? decoder.decode([Vaccination].self, from: d) {
                    vaccinations = data
                    for item in self.vaccinations {
                        if item.name == "U.S." {
                            self.editing = item
                        }
                    }
                    self.vaccinations! = self.vaccinations!.filter({
                        $0.name != "U.S."
                    })
                    self.editing!.name = "United States"
                    self.vaccinations!.append(self.editing!)
                    for item in self.vaccinations {
                        if item.name == "U.K." {
                            self.editing = item
                        }
                    }
                    self.vaccinations! = self.vaccinations!.filter({
                        $0.name != "U.K."
                    })
                    self.editing!.name = "United Kingdom"
                    self.vaccinations!.append(self.editing!)
                    self.vaccinations = self.vaccinations.sorted(by: {
                        $0.peopleVaccinated ?? 0 > $1.peopleVaccinated ?? 0
                    })
                }
            }
        }
    }
    
    func loadGlobalVaccinations() {
        let urlString = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json"

        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode([GlobalVaccination].self, from: d) {
                    let temp = data.sorted(by: {
                        $0.data.last!.peopleFullyVaccinated ?? 0 > $1.data.last!.peopleFullyVaccinated ?? 0
                    })
                    worldvaccinations = temp.first
                }
            }
        }
    }
    
    func loadStateVaccinations() {
        let urlString = "https://github.com/BloombergGraphics/covid-vaccine-tracker-data/raw/master/data/current-usa.csv"

        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
                if let data = try? decoder.decode([StateVaccination].self, from: d) {
                    
                    statevaccinations = data
                }
            }
        }
    }
}
