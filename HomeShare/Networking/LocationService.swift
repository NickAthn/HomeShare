//
//  LocationService.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class LocationService: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    let completer = MKLocalSearchCompleter()
    var queryFragment: String = ""
    @Published var suggestions: [String] = []
    
    private var cancellables: [AnyCancellable] = []

    func getLocationFrom(address: String) {
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let _ = placemarks.first?.location
                
            else {
                // handle no location found
                return
            }

            // Use your location
        }

    }
    
    func bind(text: Published<String>.Publisher){
        completer.delegate = self
        let stream = text.sink { text in
            self.completer.queryFragment = text
        }
        
        cancellables += [ stream ]
    }
}

extension LocationService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let addresses = completer.results.map { result in
            result.title + ", " + result.subtitle
        }
        suggestions = addresses
    }


}


