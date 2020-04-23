//
//  MapView.swift
//  COVID-19 Data
//
//  Created by Sammy Dentino on 4/21/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
	@Binding var centerCoordinate: CLLocationCoordinate2D
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
			parent.centerCoordinate = mapView.centerCoordinate
		}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
