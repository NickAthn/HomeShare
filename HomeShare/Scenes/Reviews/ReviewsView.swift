//
//  ReviewsView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ReviewsView: View {
    @ObservedObject var viewModel: ReviewsViewModel = ReviewsViewModel()

    var body: some View {
        ScrollView {
            Divider()
            
            Text("Reviews")
                .font(.title)
            HStack {
                Text("98%")
                    .font(.largeTitle)
            }
            
            Divider()
            
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
            Spacer().frame(height: 30)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Title")
                        .font(.headline)
                    Spacer()
                    Image("hand.thumbsdown.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                        .frame(width: 20)

                }
                Text("Decritption goes here")
            }
            .padding(20)
            .background(Color.Token.fieldDefault)
            .cornerRadius(10)
        }
        .padding([.leading,.trailing])
        .navigationBarTitle("Likes & Reviews")
        .sheet(isPresented: self.$viewModel.showAddReviewModal ) { AddReviewView() }
        
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
