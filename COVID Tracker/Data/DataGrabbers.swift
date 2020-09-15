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
    
    init() {
        loadAll()
        loadExtras()
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
}

class getCountries: ObservableObject {
    @Published var countries : [Country]!
    @Published var usa: Country!
    
    init() {
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
}

class getStates : ObservableObject {
    @Published var states : [States]!
    
    init() {
        DispatchQueue.main.async {
            self.loadStates()
            self.states = self.states.sorted(by: {
                $0.cases > $1.cases
            })
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
}

class getCounties: ObservableObject {
    @Published var counties: [County]!
    @Published var top10: [County]!
    
    init() {
        DispatchQueue.main.async {
            self.loadCounties()
            self.counties = self.counties.sorted(by: {
                $0.countyName < $1.countyName
            })
            self.top10 = self.top10.sorted(by: {
                $0.confirmed > $1.confirmed
            })
            self.top10 = Array(self.top10.prefix(10))
        }
    }
    func loadCounties() {
        let urlString = "https://covid19-us-api.herokuapp.com/county"
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(DataResponse.self, from: d) {
                    counties = data.message
                    top10 = data.message
                }
            }
        }
    }
}

class getNews : ObservableObject {
    @Published var news: [News]!
    
    init() {
        DispatchQueue.main.async {
            self.loadNews()
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

class getTimeline: ObservableObject {
    @Published var timeline : [Timeline]!
    @Published var cases = [Double]()
    @Published var deaths = [Double]()
    @Published var recovered = [Double]()
    
    init() {
        DispatchQueue.main.async {
            self.loadTimeline()
            for item in self.timeline {
                self.cases.append(item.cases)
                self.deaths.append(item.deaths)
                self.recovered.append(item.recovered)
            }
        }
        //cases = Array(cases[0..<30])
        //deaths = Array(deaths[0..<30])
        //recovered = Array(recovered[0..<30])
    }
    
    func loadTimeline() {
        let urlString = "https://covid19-api.org/api/timeline"
        if let url = URL(string: urlString) {
            if let d = try? Data(contentsOf: url) {
                // we're OK to parse!
                let decoder = JSONDecoder()
                if let data = try? decoder.decode([Timeline].self, from: d) {
                    timeline = data
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
