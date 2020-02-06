//
//  VerifyAccountView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct VerifyAccountView: View {
    var userMail: String {
        get {
            return FirebaseService.shared.session?.email ?? ""
        }
    }
    var body: some View {
        VStack {
            Image(systemName: "paperplane.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .foregroundColor(Color.Token.highlight)
                .padding()
            Text("""
                An email has be sent to \(userMail)
                Please follow the instruction to verify your account.
                """)
                .multilineTextAlignment(.center)
        }.onAppear(perform: sendVerificationMail)
    }
    
    func sendVerificationMail() {
        FirebaseService.shared.sendVerificationMail()
    }
}

struct VerifyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyAccountView()
    }
}
