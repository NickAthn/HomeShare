//
//  InboxRowView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 13/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct InboxRowView: View {
    @ObservedObject var viewModel: InboxRowViewModel
    
    init(conversation: Conversation){
        self.viewModel = InboxRowViewModel(conversation: conversation)
    }
    
    var body: some View {
        NavigationLink(destination: ConversationView(conversation: self.viewModel.conversation, to: self.viewModel.profile)) {
            HStack {
                Image(uiImage: self.viewModel.uiImage)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(.infinity)
                VStack(alignment: .leading){
                    Text(self.viewModel.title)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(self.viewModel.lastMessage)
                        .foregroundColor(.black)
                        .font(.body)
                }
            }
        }
    }
}

class InboxRowViewModel: ObservableObject {
    @Published var conversation: Conversation
    @Published var title: String = ""
    @Published var lastMessage: String = ""
    @Published var uiImage: UIImage = UIImage(named: "genericProfileImage")!
    
    @Published var profile: Profile = Profile.templateProfile
    
    init(conversation: Conversation){
        self.conversation = conversation
        self.lastMessage = conversation.lastMessage ?? ""
        self.fetchData()
    }
    
    func fetchData() {
        guard let currentUserID = FirebaseService.shared.session?.uid else { return }
        FirebaseService.shared.fetchProfile(forUID: conversation.userIDs.filter{$0 != currentUserID}.first!) { (profile) in
            if let profile = profile {
                self.title = profile.getFullName()
                self.profile = profile
                if profile.profileImageURL != "" {
                    FirStorageManager.shared.download(imageWithURL: profile.profileImageURL) { image in
                        if let image = image {
                            DispatchQueue.main.async {
                                self.uiImage = image
                            }
                        }
                    }
                }
            }
        }
    }

}
