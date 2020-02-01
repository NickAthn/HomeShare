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

    func getAddressFrom(addressString: String, completion: @escaping (_ address: Address?)-> Void) {
        var address = Address()
        geoCoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let found = placemarks.first
            else {
                // handle no location found
                return
            }
            if let city = found.locality {
                address.city = city
            }
            if let country = found.country {
                address.country = country
            }
            if let postalCode = found.postalCode {
                address.postalCode = postalCode
            }
            if let region = found.administrativeArea {
                address.region = region
            }
            
            completion(address)
        }

    }
    
    func getLocationFrom(address: Address, completion: @escaping (CLLocation?)-> Void) {
        geoCoder.geocodeAddressString(address.getDescription()) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let found = placemarks.first
            else {
                // handle no location found
                completion(nil)
                return
            }
            completion(found.location)
        }
    }
    
    func getLocationFrom(addressString: String, completion: @escaping (CLLocation?)-> Void) {
        geoCoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let found = placemarks.first
            else {
                // handle no location found
                completion(nil)
                return
            }
            completion(found.location)
        }
    }
    
    func searchLocationgWith(addressString: String, completion: @escaping (CLLocation?)-> Void){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = addressString
        
        let search = MKLocalSearch(request: request)
        
        search.start() {(response, error) in
            if let results = response {
            
                if let err = error {
                    print("Error occurred in search: \(err.localizedDescription)")
                } else if results.mapItems.count == 0 {
                    print("No matches found")
                } else {
                    print("Matches found")
                    
//                    for item in results.mapItems {
//                        print("Name = \(item.name ?? "No match")")
//                        print("Phone = \(item.phoneNumber ?? "No Match")")
//
//                        item.placemark.coordinate
//                    }
                    guard let coordinates = results.mapItems.first?.placemark.coordinate else {
                        completion(nil)
                        return
                    }
                    
                    completion(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
                }
            }
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

