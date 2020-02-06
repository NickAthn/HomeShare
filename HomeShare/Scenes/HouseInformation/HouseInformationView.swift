//
//  HouseInformationView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct HouseInformationView: View {
    @ObservedObject var viewModel: HouseInformationViewModel
    init(home: Home) {
        viewModel = HouseInformationViewModel(home: home)
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Max Guests")
                    Spacer()
                    Text(viewModel.maxGuests)
                        .foregroundColor(Color.secondary)
                }
                HStack {
                    Text("Pets")
                    Spacer()
                    Text(viewModel.petsAllowed)
                        .foregroundColor(Color.secondary)
                }
                HStack {
                    Text("Smoking in house")
                    Spacer()
                    Text(viewModel.smokingAllowed)
                        .foregroundColor(Color.secondary)
                }
                HStack {
                    Text("Kid Friendly")
                    Spacer()
                    Text(viewModel.kidFriendly)
                        .foregroundColor(Color.secondary)
                }
                HStack {
                    Text("Wheelchair Accessible")
                    Spacer()
                    Text(viewModel.wheelChairAccessible)
                        .foregroundColor(Color.secondary)
                }
                HStack {
                    Text("Sleeping Arrangments")
                    Spacer()
                    Text(viewModel.sleepingArrangments)
                        .foregroundColor(Color.secondary)
                }

                HStack {
                    Text("Accepting Same Day Requests")
                    Spacer()
                    Text(viewModel.receiveSameDayRequests)
                        .foregroundColor(Color.secondary)
                }

            }
        }.navigationBarTitle("House Information")
    }
}
