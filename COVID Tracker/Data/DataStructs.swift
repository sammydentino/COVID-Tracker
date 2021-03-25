//
//  DataStructs.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 2/6/21.
//  Copyright © 2021 Sammy Dentino. All rights reserved.
//

import SwiftUI
import Default

struct Global : Codable, DefaultStorable {
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
struct Welcome : Codable, DefaultStorable {
    let global : GlobalExtras!

    enum CodingKeys: String, CodingKey {
        case global = "Global"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        global = try values.decodeIfPresent(GlobalExtras.self, forKey: .global)
    }
}

struct GlobalExtras : Codable, DefaultStorable {
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

struct Vaccination: Codable, Identifiable {
    let id = UUID()
    let country, isoCode: String
    let data: [VaccinationData]

    enum CodingKeys: String, CodingKey {
        case country
        case isoCode = "iso_code"
        case data
    }
}

struct VaccinationData: Codable, Identifiable {
    let id = UUID()
    let date: String
    let totalVaccinations, peopleVaccinated: Int?
    let totalVaccinationsPerHundred, peopleVaccinatedPerHundred: Double?
    let dailyVaccinations, dailyVaccinationsPerMillion, dailyVaccinationsRaw, peopleFullyVaccinated: Int?
    let peopleFullyVaccinatedPerHundred: Double?

    enum CodingKeys: String, CodingKey {
        case date
        case totalVaccinations = "total_vaccinations"
        case peopleVaccinated = "people_vaccinated"
        case totalVaccinationsPerHundred = "total_vaccinations_per_hundred"
        case peopleVaccinatedPerHundred = "people_vaccinated_per_hundred"
        case dailyVaccinations = "daily_vaccinations"
        case dailyVaccinationsPerMillion = "daily_vaccinations_per_million"
        case dailyVaccinationsRaw = "daily_vaccinations_raw"
        case peopleFullyVaccinated = "people_fully_vaccinated"
        case peopleFullyVaccinatedPerHundred = "people_fully_vaccinated_per_hundred"
    }
}
