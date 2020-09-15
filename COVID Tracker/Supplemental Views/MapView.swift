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
