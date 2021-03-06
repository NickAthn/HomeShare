//
//  AddReviewView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AddReviewView: View {
    @ObservedObject var viewModel: AddReviewViewModel
    @Environment(\.presentationMode) var presentationMode

    init(profile: Profile) {
        viewModel = AddReviewViewModel(profile: profile)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
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
                    Text("Tap a symbol to rate")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }.padding(.top)
                Divider()
                TextField("Title", text: self.$viewModel.title)
                
                Divider()
                TextView(text: self.$viewModel.desc, placeholder: "Description")
                    .frame(height: 400)
            }
            .navigationBarTitle("Write a Review")
            .navigationBarItems(trailing: Button(action: self.submitReview) {Text("Send")}.disabled(viewModel.isSendButtonDisabled) )
            .padding([.leading,.trailing])
        }
    }
    
    func submitReview() {
        viewModel.send()
        presentationMode.wrappedValue.dismiss()
    }
    
}
