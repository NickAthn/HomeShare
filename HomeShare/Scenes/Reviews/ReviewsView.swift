//
//  ReviewsView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ReviewsView: View {
    @ObservedObject var viewModel: ReviewsViewModel
    var reviews: [Review] = []
    init(profile: Profile, isViewOnly: Bool, reviews: [Review]) {
        viewModel = ReviewsViewModel(profile: profile, isViewOnly: isViewOnly, reviews: reviews)
        self.reviews = reviews
    }

    var body: some View {
        ScrollView {
            Divider()
            
            Text("Reviews")
                .font(.title)
            if viewModel.reviews.isEmpty {
                Text("No reviews have been made yet.")
                    .font(.headline)
            } else {
                HStack(alignment: .lastTextBaseline) {
                    Text("\(viewModel.likePercentage)%")
                        .font(.largeTitle)
                    Text("of people like this person")
                        .font(.headline)
                }
            }
            Divider()
            if viewModel.isViewOnly {
                HStack {
                    Text("Tap to rate: ")
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {self.viewModel.isLikePressed.toggle()}) {
                        if viewModel.isLikePressed {
                            Image(systemName: "hand.thumbsup.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .accentColor(.green)
                    .frame(width: 30)
                    Spacer().frame(width: 50)
                    Button(action: {self.viewModel.isDislikedPressed.toggle()}) {
                        if viewModel.isDislikedPressed {
                            Image(systemName: "hand.thumbsdown.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "hand.thumbsdown")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .accentColor(.red)
                    .frame(width: 30)
                }
                
                HStack {
                    Button(action: { self.viewModel.showAddReviewModal.toggle() } ) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Write a review")
                        }
                    }
                    Spacer()
                }
            }
            Spacer().frame(height: 30)
            
            ForEach(self.viewModel.displayedReviews, id: \.self) { review in
                ReviewDisplayRow(review: review)
            }
        }
        .padding([.leading,.trailing])
        .navigationBarTitle("Likes & Reviews")
        .sheet(isPresented: self.$viewModel.showAddReviewModal ) { AddReviewView(profile: self.viewModel.profile) }
    }
}

struct ReviewDisplayRow: View {
    let review: Review
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(review.title ?? "")
                    .font(.headline)
                Spacer()
                Image(review.isLiked ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(review.isLiked ? Color.green : Color.red)
                    .frame(width: 20)

            }
            Text(review.description ?? "")
            
        }
        .padding(20)
        .background(Color.Token.fieldDefault)
        .cornerRadius(10)
    }
}
