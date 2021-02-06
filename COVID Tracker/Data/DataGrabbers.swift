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
    @Published var cases = [Double]()
    @Published var deaths = [Double]()
    @Published var recovered = [Double]()
    
    init() {
        loadAll()
        loadExtras()
        self.loadCountries()
        for item in self.countries! {
            if item.country == "USA" {
                usa = item
            }
        }
        self.countries! = self.countries!.filter({
            $0.country != "USA"
        })
        self.usa!.country = "United States"
        self.countries!.append(self.usa!)
        self.countries! = self.countries!.sorted(by: {
            $0.cases > $1.cases
        })
        DispatchQueue.main.async {
            self.loadStates()
            self.states = self.states.sorted(by: {
                $0.cases > $1.cases
            })
            self.loadNews()
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
                    countries = data
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
                    states = data
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
                    news = data.news
                }
            }
        }
    }
}

class CoronaObservable : ObservableObject {
    @Published var caseAnnotations = [CaseAnnotations]()
    @Published var coronaOutbreak = (totalCases: 0, totalRecovered: 0, totalDeaths: 0)

    var url = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query"
    var cancellable : Set<AnyCancellable> = Set()
    
    init() {
        DispatchQueue.main.async {
            self.fetchCoronaCases()
        }
    }
    
    func fetchCoronaCases() {
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [
            URLQueryItem(name: "f", value: "json"),
            URLQueryItem(name: "where", value: "Confirmed > 0"),
            URLQueryItem(name: "geometryType", value: "esriGeometryEnvelope"),
            URLQueryItem(name: "spatialRef", value: "esriSpatialRelIntersects"),
            URLQueryItem(name: "outFields", value: "*"),
            URLQueryItem(name: "orderByFields", value: "Confirmed desc"),
            URLQueryItem(name: "resultOffset", value: "0"),
            URLQueryItem(name: "cacheHint", value: "true")
        ]
        URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .map{$0.data}
            .decode(type: CoronaResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
        }) { response in
            self.casesByProvince(response: response)
        }
        .store(in: &cancellable)
    }
    
    func casesByProvince(response: CoronaResponse) {
        var caseAnnotations : [CaseAnnotations] = []
        var totalCases = 0
        var totalDeaths = 0
        var totalRecovered = 0

        for cases in response.features {
            let confirmed = cases.attributes.confirmed ?? 0

            caseAnnotations.append(CaseAnnotations(title: cases.attributes.provinceState ?? cases.attributes.countryRegion ?? "", subtitle: confirmed.withCommas(), coordinate: .init(latitude: cases.attributes.lat ?? 0.0, longitude: cases.attributes.longField ?? 0.0)))

            totalCases += confirmed
            totalDeaths += cases.attributes.deaths ?? 0
            totalRecovered += cases.attributes.recovered ?? 0
        }
        self.coronaOutbreak.totalCases = totalCases
        self.coronaOutbreak.totalDeaths = totalDeaths
        self.coronaOutbreak.totalRecovered = totalRecovered
        self.caseAnnotations = caseAnnotations
    }
}
