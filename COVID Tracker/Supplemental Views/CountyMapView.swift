//
//  CountyMapView.swift
//  COVID Tracker
//
//  Created by Sammy Dentino on 9/15/20.
//  Copyright © 2020 Sammy Dentino. All rights reserved.
//

import SwiftUI
import MapKit

struct CountyMapView: UIViewRepresentable {
    let lat: Double!
    let long: Double!
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: lat ?? 0.0, longitude: long ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        uiView.isZoomEnabled = false
        uiView.isScrollEnabled = false
        uiView.isUserInteractionEnabled = false
    }
}
