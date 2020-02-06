//
//  MapView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import MapKit
import UIKit
import CoreLocation

struct MapView: UIViewRepresentable {
    var showUserLocation = false
    var location: CLLocation?
    
    
    init() {}
    init(_ location: CLLocation) {
        self.location = location
        self.pointLocation()
    }
    
    var locationManager = CLLocationManager()

    func makeUIView(context: Context) -> MKMapView {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // In this application we wont ever need more accuracy
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = context.coordinator
        
        let mapView = MKMapView(frame: UIScreen.main.bounds)

        mapView.showsUserLocation = showUserLocation
        //    mapView.userTrackingMode = .follow
        
        if let locationToPoint = location  {
            
            let point = MKPointAnnotation()
            point.title = "Home"
            point.coordinate = locationToPoint.coordinate
            mapView.addAnnotation(point)
            
            let viewRegion = MKCoordinateRegion(center: locationToPoint.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
            mapView.setRegion(viewRegion, animated: true)
        }
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    

    
    class Coordinator : NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        var parent: MapView
        init(_ uiMapView: MapView) {
            self.parent = uiMapView
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            mapView.showAnnotations(views.map{$0.annotation!} , animated: true)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }

            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }
            mapView.showAnnotations([annotation], animated: true)
            return annotationView
        }


    }
    
    func pointLocation() {
        
    }
}
