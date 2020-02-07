//
//  DashboardViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class DashboardViewModel: ObservableObject {
    @Published var taskList: [Task] = []
    @Published var profilesNear: [Profile] = []
    
    var locationService = LocationService()
    @Published var lastUserLocation: CLLocation? = nil {
        didSet {
            findProfilesNear()
        }
    }
    @Published var isLocationLoading: Bool = false
    
    var cancellables: [AnyCancellable] = []
    
    init() {
        generateTaskList()
        bindLocationStatus()
    }
    func bindLocationStatus() {
        let locationStream = locationService.$lastUserLocation.sink { lastUserLocation in
            self.lastUserLocation = lastUserLocation
        }
        
        cancellables += [locationStream]
    }
    func generateTaskList() {
        if let verificationStatus = FirebaseService.shared.session?.verificationStatus {
            if verificationStatus == .notVerified {
                taskList.append(Task.systemTasks.first {$0.id == "verificationNeeded"}!)
            }
        }
    }
    func requestLocationAccess() {
        isLocationLoading = true
        locationService.locationManager.requestWhenInUseAuthorization()
//        findProfilesNear()
    }
    func findProfilesNear() {
        if let location = lastUserLocation {
            FirebaseService.shared.findProfiles(nearLocation: location) { (profiles) in
                self.isLocationLoading = false
                self.profilesNear = profiles
            }
        }
    }
}
