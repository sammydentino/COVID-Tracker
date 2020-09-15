//
//  JSONStructs.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI

struct Global : Codable {
    let updated : Int?
    let cases : Int!
    let todayCases : Int!
    let deaths : Int!
    let todayDeaths : Int!
    let recovered : Int!
    let todayRecovered : Int!
    let active : Int!
    let critical : Int!
    let casesPerOneMillion : Int?
    let deathsPerOneMillion : Double?
    let tests : Int!
    let testsPerOneMillion : Double?
    let population : Int?
    let oneCasePerPeople : Int?
    let oneDeathPerPeople : Int?
    let oneTestPerPeople : Int?
    let activePerOneMillion : Double?
    let recoveredPerOneMillion : Double?
    let criticalPerOneMillion : Double?
    let affectedCountries : Int!
    let deathRate: Double!
    let recoveredRate: Double!
    let activeVsConf: Double!

    enum CodingKeys: String, CodingKey {

        case updated = "updated"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case todayRecovered = "todayRecovered"
        case active = "active"
        case critical = "critical"
        case casesPerOneMillion = "casesPerOneMillion"
        case deathsPerOneMillion = "deathsPerOneMillion"
        case tests = "tests"
        case testsPerOneMillion = "testsPerOneMillion"
        case population = "population"
        case oneCasePerPeople = "oneCasePerPeople"
        case oneDeathPerPeople = "oneDeathPerPeople"
        case oneTestPerPeople = "oneTestPerPeople"
        case activePerOneMillion = "activePerOneMillion"
        case recoveredPerOneMillion = "recoveredPerOneMillion"
        case criticalPerOneMillion = "criticalPerOneMillion"
        case affectedCountries = "affectedCountries"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        updated = try values.decodeIfPresent(Int.self, forKey: .updated)
        cases = try values.decodeIfPresent(Int.self, forKey: .cases)
        todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases)
        deaths = try values.decodeIfPresent(Int.self, forKey: .deaths)
        todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths)
        recovered = try values.decodeIfPresent(Int.self, forKey: .recovered)
        todayRecovered = try values.decodeIfPresent(Int.self, forKey: .todayRecovered)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        critical = try values.decodeIfPresent(Int.self, forKey: .critical)
        casesPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .casesPerOneMillion)
        deathsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .deathsPerOneMillion)
        tests = try values.decodeIfPresent(Int.self, forKey: .tests)
        testsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .testsPerOneMillion)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        oneCasePerPeople = try values.decodeIfPresent(Int.self, forKey: .oneCasePerPeople)
        oneDeathPerPeople = try values.decodeIfPresent(Int.self, forKey: .oneDeathPerPeople)
        oneTestPerPeople = try values.decodeIfPresent(Int.self, forKey: .oneTestPerPeople)
        activePerOneMillion = try values.decodeIfPresent(Double.self, forKey: .activePerOneMillion)
        recoveredPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .recoveredPerOneMillion)
        criticalPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .criticalPerOneMillion)
        affectedCountries = try values.decodeIfPresent(Int.self, forKey: .affectedCountries)
        deathRate = ((Double(deaths)) / (Double(cases))) * 100
        recoveredRate = ((Double(recovered) / Double(cases))) * 100
        activeVsConf = ((Double(active) / Double(cases))) * 100
    }
}

// Welcome & GlobalExtras
struct Welcome : Codable {
    let global : GlobalExtras!

    enum CodingKeys: String, CodingKey {
        case global = "Global"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        global = try values.decodeIfPresent(GlobalExtras.self, forKey: .global)
    }
}

struct GlobalExtras : Codable {
    let newConfirmed : Int?
    let totalConfirmed : Int?
    let newDeaths : Int?
    let totalDeaths : Int?
    let newRecovered : Int!
    let totalRecovered : Int?

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        newConfirmed = try values.decodeIfPresent(Int.self, forKey: .newConfirmed)
        totalConfirmed = try values.decodeIfPresent(Int.self, forKey: .totalConfirmed)
        newDeaths = try values.decodeIfPresent(Int.self, forKey: .newDeaths)
        totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths)
        newRecovered = try values.decodeIfPresent(Int.self, forKey: .newRecovered) ?? 0
        totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered)
    }
}

struct CountriesIn : Codable {
    let data : [CountriesList]!
    let dt : String?
    let ts : Int?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case dt = "dt"
        case ts = "ts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CountriesList].self, forKey: .data)
        dt = try values.decodeIfPresent(String.self, forKey: .dt)
        ts = try values.decodeIfPresent(Int.self, forKey: .ts)
    }
}

struct CountriesList : Codable, Identifiable {
    let id = UUID()
    var location : String!
    let confirmed : Int!
    let deaths : Int!
    let recovered : Int!
    let active : Int!
    let deathRate: Double!
    let recoveredRate: Double!
    let activeVsConf: Double!

    enum CodingKeys: String, CodingKey {
        case location = "location"
        case confirmed = "confirmed"
        case deaths = "deaths"
        case recovered = "recovered"
        case active = "active"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
        confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
        deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
        recovered = try values.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
        active = try values.decodeIfPresent(Int.self, forKey: .active) ?? 0
        deathRate = ((Double(deaths)) / (Double(confirmed))) * 100
        recoveredRate = ((Double(recovered) / Double(confirmed))) * 100
        activeVsConf = ((Double(active) / Double(confirmed))) * 100
        if location == "US" {
            location = "United States"
        }
    }
}

struct States : Codable, Identifiable {
    let id = UUID()
    let state : String!
    let cases : Int!
    let todayCases : Int!
    let deaths : Int!
    let todayDeaths : Int!
    let recovered: Int!
    let active : Int!
    let tests : Int!
    let testsPerOneMillion : Int!
    let population: Int!
    let deathRate: Double!
    let testedRate: Double!
    let activeVsConf: Double!

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case active = "active"
        case tests = "tests"
        case testsPerOneMillion = "testsPerOneMillion"
        case population = "population"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        cases = try values.decodeIfPresent(Int.self, forKey: .cases)
        todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases)
        deaths = try values.decodeIfPresent(Int.self, forKey: .deaths)
        todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths)
        recovered = try values.decodeIfPresent(Int.self, forKey: .recovered)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        tests = try values.decodeIfPresent(Int.self, forKey: .tests)
        testsPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .testsPerOneMillion)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        deathRate = ((Double(deaths)) / (Double(cases))) * 100
        testedRate = ((Double(tests) / Double(cases))) * 100
        activeVsConf = ((Double(active) / Double(cases))) * 100
    }
}

struct DataResponse : Codable {
    let success : Bool!
    let message : [County]!

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent([County].self, forKey: .message)
    }
}

struct County : Codable, Identifiable {
    let id = UUID()
    let countyName : String!
    let stateName : String!
    let confirmed : Int!
    let new : Int!
    let deaths : Int!
    let newDeaths : Int!
    let fatalityRate : String!
    let latitude : Double!
    let longitude : Double!
    let update : String!

    enum CodingKeys: String, CodingKey {
        case countyName = "county_name"
        case stateName = "state_name"
        case confirmed = "confirmed"
        case new = "new"
        case deaths = "death"
        case newDeaths = "new_death"
        case fatalityRate = "fatality_rate"
        case latitude = "latitude"
        case longitude = "longitude"
        case update = "last_update"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countyName = try values.decodeIfPresent(String.self, forKey: .countyName) ?? "N/A"
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName) ?? "N/A"
        confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed) ?? 0
        new = try values.decodeIfPresent(Int.self, forKey: .new) ?? 0
        deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
        newDeaths = try values.decodeIfPresent(Int.self, forKey: .newDeaths) ?? 0
        fatalityRate = try values.decodeIfPresent(String.self, forKey: .fatalityRate) ?? "N/A"
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        update = try values.decodeIfPresent(String.self, forKey: .update) ?? "N/A"
    }
}

struct Results : Codable {
    let status : String?
    let news : [News]!
    let page : Int?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case news = "news"
        case page = "page"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        news = try values.decodeIfPresent([News].self, forKey: .news)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
    }
}

struct News : Codable, Identifiable {
    let id = UUID()
    let title : String!
    let description : String!
    let url : String!
    let author : String!
    let image : String!
    let language : String?
    let category : [String]?
    let published : String?

    enum CodingKeys: String, CodingKey {
        //case id = "id"
        case title = "title"
        case description = "description"
        case url = "url"
        case author = "author"
        case image = "image"
        case language = "language"
        case category = "category"
        case published = "published"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? "N/A"
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? "N/A"
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? "https://www.google.com"
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? "N/A"
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? "https://www.google.com"
        language = try values.decodeIfPresent(String.self, forKey: .language) ?? "N/A"
        category = try values.decodeIfPresent([String].self, forKey: .category) ?? ["N/A"]
        published = try values.decodeIfPresent(String.self, forKey: .published) ?? "N/A"
    }
}

struct CoronaResponse : Codable {
    public var features: [CoronaCases]
        
    private enum CodingKeys: String, CodingKey {
        case features
    }
}

struct CoronaCases : Codable {
    public var attributes: CaseAttributes

    private enum CodingKeys: String, CodingKey {
        case attributes
    }
}

struct CaseAttributes : Codable {
    let confirmed : Int?
    let countryRegion : String?
    let deaths : Int?
    let lat : Double?
    let longField : Double?
    let provinceState : String?
    let recovered : Int?

    enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case countryRegion = "Country_Region"
        case deaths = "Deaths"
        case lat = "Lat"
        case longField = "Long_"
        case provinceState = "Province_State"
        case recovered = "Recovered"
    }
}

struct Timeline : Codable, Identifiable {
    let id = UUID()
    var update : String!
    let totalCases : Int!
    let totalDeaths : Int!
    let totalRecovered : Int!
    var cases: Double!
    var deaths: Double!
    var recovered: Double!
    var dateFormatter = DateFormatter()
    var dateFormatterPrint = DateFormatter()
    var datein: Date!
    var dateout: String!

    enum CodingKeys: String, CodingKey {
        case update = "last_update"
        case totalCases = "total_cases"
        case totalDeaths = "total_deaths"
        case totalRecovered = "total_recovered"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        update = try values.decodeIfPresent(String.self, forKey: .update)
        totalCases = try values.decodeIfPresent(Int.self, forKey: .totalCases) ?? 0
        totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths) ?? 0
        totalRecovered = try values.decodeIfPresent(Int.self, forKey: .totalRecovered) ?? 0
        cases = Double(totalCases)
        deaths = Double(totalDeaths)
        recovered = Double(totalRecovered)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatterPrint.dateFormat = "MMMM dd"
        datein = dateFormatter.date(from: update)
        dateout = dateFormatterPrint.string(from: datein ?? Date())
        //date = dateFormatter.string(from: Date(timeIntervalSince1970: update))
    }
}

struct Country: Codable, Identifiable {
    let id = UUID()
    var updated: Int
    var country: String
    var countryInfo: CountryInfo
    var cases, todayCases, deaths, todayDeaths: Int
    var recovered, todayRecovered, active, critical: Int
    var casesPerOneMillion: Int
    var deathsPerOneMillion: Double
    var tests, testsPerOneMillion, population: Int
    var continent: Continent
    var oneCasePerPeople, oneDeathPerPeople, oneTestPerPeople: Int
    var activePerOneMillion, recoveredPerOneMillion, criticalPerOneMillion: Double
}

enum Continent: String, Codable {
    case africa = "Africa"
    case asia = "Asia"
    case australiaOceania = "Australia/Oceania"
    case empty = ""
    case europe = "Europe"
    case northAmerica = "North America"
    case southAmerica = "South America"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.countryInfoTask(with: url) { countryInfo, response, error in
//     if let countryInfo = countryInfo {
//       ...
//     }
//   }
//   task.resume()

// MARK: - CountryInfo
struct CountryInfo: Codable {
    var id: Int?
    var iso2, iso3: String?
    var lat, long: Double
    var flag: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case iso2, iso3, lat, long, flag
    }
}
