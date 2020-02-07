//
//  SearchViewRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
//
struct SearchViewRow: View {
    @ObservedObject var viewModel: SearchViewRowViewModel
    
    init(withProfile: Profile) {
        self.viewModel = SearchViewRowViewModel(profile: withProfile)
    }
    
    var body: some View {
        NavigationLink (destination: ProfileView(profile: viewModel.profile)) {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    Image(uiImage: viewModel.profileImage)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .overlay(
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [.black, .clear, .clear, .black]), startPoint: .top, endPoint: .bottom))
                                .opacity(0.4)
                        )
                        .cornerRadius(10)
                        .clipped()

                    VStack(alignment: .leading) {
                        Text("\(viewModel.profile.firstName) \(viewModel.profile.lastName)" )
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .black, design: .default))
                        Text("\(viewModel.profile.home.address.getDescription())")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold, design: .default))
                    }
                    .padding(.leading)
                    .padding(.bottom)
                }
            }
        }
    }
    

}
// Fast Temp Solution. TODO: Change
class SearchViewRowViewModel: ObservableObject {
    @Published var profileImage: UIImage = UIImage(named: "genericProfileImage")!
    @Published var profile: Profile!
    init(profile: Profile) {
        self.profile = profile
        loadProfileImage()
    }
    func loadProfileImage() {
        if profile.profileImageURL != "" {
            FirStorageManager.shared.download(imageWithURL: profile.profileImageURL) { (image) in
                DispatchQueue.main.async {
                    if let image = image {
                        self.profileImage = image
                    }
                }
                
            }
        }
    }

}
