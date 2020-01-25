//
//  GIDSignInButton.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 24/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import UIKit
import Combine

/// - Description: A Button used to authenticate with google
struct GoogleLoginButton: View {
    var body: some View {
        Button(action: self.login) {
            HStack{
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.20))
                    Image("google_plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        
                }.frame(width: 52, height: 52)
                Spacer()
                Text("Login with Google")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.trailing)
                Spacer()

            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .background(Color(red: 244/255, green: 67/255, blue: 54/255))
        .cornerRadius(8)
        .foregroundColor(.white)
        .frame(height: 52)
    }
    
    func login() {
        SocialLogin().attemptLoginGoogle()
    }
}

struct GoogleLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleLoginButton()
    }
}

struct SocialLogin: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SocialLogin>) -> UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SocialLogin>) {}
    func attemptLoginGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
}
