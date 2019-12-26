//
//  RegisterView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 21/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""

    // Variable to programaticaly dismish modal
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()

    var body: some View {
        VStack(spacing: 10) {
            Image("logo").padding()
            
            Group {
                HStack {
                    TextField("First Name",text: $firstName)
                    TextField("Last Name",text: $lastName)
                }
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Re-Enter Password", text: $passwordConfirmation)
            }
            .padding()
            .background(Color.Token.fieldDefault)
            .cornerRadius(8)
            
            RoundedButton(title: "Register"){self.register()}
        }
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        .alert(isPresented: $viewModel.isErrorShown) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
    
    func register() {
        viewModel.register(mail: self.email, password: self.password, firstName: firstName, lastName: lastName)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
