//
//  ContentView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack{
            Image("logo")
            Text("HomeShare")
                .font(.system(size: 34, weight: .regular, design: .rounded))
                .foregroundColor(Color.Token.textHighlight)
            Text("We connect people")
            Spacer().frame(height: 30)
            
            TextField("Username or mail", text: $username)
                .padding()
                .background(Color.Token.fieldDefault)
                .cornerRadius(8)
            Spacer().frame(height: 18)
            SecureField("Password", text: $password)
                .padding()
                .background(Color.Token.fieldDefault)
                .cornerRadius(8)
            Spacer().frame(height: 18)
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Text("LOGIN")
                        .font(.system(size: 20, weight: .bold, design: .default))
                    Spacer()
                }
            }.buttonStyle(RoundedButtonStyle())
            
            HStack {
                Text("Register Now").foregroundColor(Color.Token.highlight)
                Spacer()
                Text("Forgot Password").foregroundColor(Color.Token.inactive)
            }.padding(.top)
        }
    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
