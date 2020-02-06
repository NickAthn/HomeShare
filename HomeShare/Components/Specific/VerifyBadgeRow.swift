//
//  VerifyBadgeRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct VerifyBadgeRow: View {
    var profile: Profile
    var verificationStatus: VerificationStatus {
        get {
            return profile.verificationStatus ?? .notVerified
        }
    }

    @State var isViewOnly: Bool
    @State var showVerifyModal: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 30)
                .foregroundColor(verificationStatus.color)
            HStack {
                verificationStatus.image
                    .foregroundColor(.white)
                Text(verificationStatus.description)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .bold, design: .default))
            }.padding(.leading, 6)
        }.onTapGesture {
            self.showModal()
        }
        .sheet(isPresented: $showVerifyModal) {
            VerifyAccountView()
        }
    }
    
    func showModal() {
        if verificationStatus == .notVerified && isViewOnly == false {
            showVerifyModal.toggle()
        }
    }
}
