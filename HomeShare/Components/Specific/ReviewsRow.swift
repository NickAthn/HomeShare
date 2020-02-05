//
//  ReviewsRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ReviewsRow: View {
    @State var likes = 0
    @State var dislikes = 0
    @State var reviews: [Review] = []
    var isViewOnly: Bool
    var profile: Profile
    
    init(isViewOnly: Bool, profile: Profile) {
        self.isViewOnly = isViewOnly
        self.profile = profile
        self.fetchReviews()
    }
    
    var body: some View {
        NavigationLink(destination: ReviewsView(profile: profile, isViewOnly: isViewOnly, reviews: reviews)){
            HStack {
                Image(systemName: "quote.bubble.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .foregroundColor(.black)
                Text("Reviews")
                    .foregroundColor(.black)
                    .font(.system(size: 17, weight:.medium, design: .rounded))
                Spacer()
                
                Group {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(.green)
                    Text("\(likes)").padding(.trailing, 10)
                        .foregroundColor(.black)

                }

                Group {
                    Image(systemName: "hand.thumbsdown.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(.red)
                    Text("\(dislikes)").padding(.trailing, 5)
                        .foregroundColor(.black)
                }

                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.5))
            }
            .padding([.leading,.trailing], 12)
            .onAppear(perform: fetchReviews)
        }
    }
    
    func fetchReviews() {
        if let reviewIDS = profile.reviewIDS {
            FirebaseService.shared.fetchReviews(ids: reviewIDS) { reviews in
                self.reviews = reviews!
                self.likes = reviews?.filter { $0.isLiked }.count ?? 0
                self.dislikes = reviews?.filter { !$0.isLiked }.count ?? 0

            }
        }
    }
}
