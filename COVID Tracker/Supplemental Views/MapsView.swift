//
//  MapsView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 5/2/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//
// Huge thanks to Anupam Chugh and his tutorial!
// https://heartbeat.fritz.ai/coronavirus-visualisation-on-maps-with-swiftui-and-combine-on-ios-c3f6e04c2634
//

import SwiftUI
import MapKit
import Combine

struct MapsView: View {
	@ObservedObject private var coronaCases = CoronaObservable()
	@ObservedObject private var fetch = getAll()
	@State private var showingDetail = false
    var body: some View {
		VStack(alignment: .leading){
			Group {
				HStack{
					Text("Total Cases").font(.subheadline).bold()
					Spacer()
					Text("\(coronaCases.coronaOutbreak.totalCases.withCommas())")
						.foregroundColor(Color(red: 0, green: 0.6588, blue: 0.9882))
						.font(.subheadline)
						.bold()
				}.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
				Spacer()
				HStack{
					Text("Deaths").font(.subheadline).bold()
					Spacer()
					Text("\(coronaCases.coronaOutbreak.totalDeaths.withCommas())")
						.font(.subheadline)
						.foregroundColor(.red)
						.bold()
				}.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
				Spacer()
				HStack {
					Text("Active Cases")
						.font(.subheadline)
						.bold()
					Spacer()
					Text("\(fetch.global.active.withCommas())")
						.foregroundColor(.orange)
						.font(.subheadline)
						.bold()
				}.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
				Spacer()
			}
			HStack{
				Text("Recovered").font(.subheadline).bold()
				Spacer()
				Text("\(coronaCases.coronaOutbreak.totalRecovered.withCommas())")
					.font(.subheadline)
					.foregroundColor(.green)
					.bold()
			}.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
			Spacer()
			HStack {
				Text("Tests Recorded")
					.font(.subheadline)
					.bold()
				Spacer()
				Text("\(fetch.global.tests.withCommas())")
					.foregroundColor(.purple)
					.font(.subheadline)
					.bold()
			}.padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
			Spacer()
			Button(action: {
				self.showingDetail.toggle()
			}) {
				Text("Source Information")
					.font(.subheadline)
					.bold()
					.padding(.leading, 15)
					.foregroundColor(.gray)
			}.sheet(isPresented: $showingDetail) {
				NavigationView {
					SourcesView().navigationBarTitle("Sources")
				}
			}
			MapView(coronaCases: coronaCases.caseAnnotations, totalCases: coronaCases.coronaOutbreak.totalCases)
		}
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
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

class CoronaObservable : ObservableObject {
    @Published var caseAnnotations = [CaseAnnotations]()
    @Published var coronaOutbreak = (totalCases: 0, totalRecovered: 0, totalDeaths: 0)

    var url = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query"
    var cancellable : Set<AnyCancellable> = Set()
    
    init() {
        fetchCoronaCases()
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

class CaseAnnotations: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

struct MapView: UIViewRepresentable {
    var coronaCases: [CaseAnnotations]
    var totalCases : Int

    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.addAnnotations(coronaCases)
		
        if let first = coronaCases.first {
            view.selectAnnotation(first, animated: true)
        }
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
	
    init(_ control: MapView) {
        self.mapViewController = control
    }
	
    func mapView(_ mapView: MKMapView, viewFor
        annotation: MKAnnotation) -> MKAnnotationView?{
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "anno")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "anno")
            annotationView?.canShowCallout = true
		}
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = annotation.subtitle ?? "NA"
        subtitleLabel.numberOfLines = 0
        annotationView?.detailCalloutAccessoryView = subtitleLabel
        return annotationView
    }
}

class getAll : ObservableObject {
	@Published var global : Global!
	init() {
		loadAll()
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
}

struct Global : Codable {
	let updated : Int?
	let cases : Int!
	let todayCases : Int!
	let deaths : Int!
	let todayDeaths : Int!
	let recovered : Int!
	let active : Int!
	let critical : Int!
	let casesPerOneMillion : Int!
	let deathsPerOneMillion : Int!
	let tests : Int!
	let testsPerOneMillion : Double!
	let affectedCountries : Int!

	enum CodingKeys: String, CodingKey {
		case updated = "updated"
		case cases = "cases"
		case todayCases = "todayCases"
		case deaths = "deaths"
		case todayDeaths = "todayDeaths"
		case recovered = "recovered"
		case active = "active"
		case critical = "critical"
		case casesPerOneMillion = "casesPerOneMillion"
		case deathsPerOneMillion = "deathsPerOneMillion"
		case tests = "tests"
		case testsPerOneMillion = "testsPerOneMillion"
		case affectedCountries = "affectedCountries"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		updated = try values.decodeIfPresent(Int.self, forKey: .updated) ?? 0
		cases = try values.decodeIfPresent(Int.self, forKey: .cases) ?? 0
		todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases) ?? 0
		deaths = try values.decodeIfPresent(Int.self, forKey: .deaths) ?? 0
		todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths) ?? 0
		recovered = try values.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
		active = try values.decodeIfPresent(Int.self, forKey: .active) ?? 0
		critical = try values.decodeIfPresent(Int.self, forKey: .critical) ?? 0
		casesPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .casesPerOneMillion) ?? 0
		deathsPerOneMillion = try values.decodeIfPresent(Int.self, forKey: .deathsPerOneMillion) ?? 0
		tests = try values.decodeIfPresent(Int.self, forKey: .tests)
		testsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .testsPerOneMillion) ?? 0
		affectedCountries = try values.decodeIfPresent(Int.self, forKey: .affectedCountries) ?? 0
	}
}
