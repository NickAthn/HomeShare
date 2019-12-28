//
//  ContentView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERTIES
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()

    @State private var username: String = ""
    @State private var password: String = ""

    // MARK: - VIEW
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            NavigationView {
                VStack {
                    // Navigation Links
                    NavigationLink(destination: MainTabView(), isActive: self.$viewModel.showMainTab) { EmptyView() }.hidden()

                    // View
                    Image("logo")
                    Text("HomeShare")
                        .font(Font.system(size: 34, weight: .regular, design: .rounded))
                        .foregroundColor(Color.Token.textHighlight)
                    Text("We connect people")
                    
                    Spacer().frame(height: 30)
                    
                    VStack(spacing: 18) {
                        Group {
                            TextField("Username or mail", text: self.$username)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                            SecureField("Password", text: self.$password)
                                .textContentType(.password)
                        }
                        .padding()
                        .background(Color.Token.fieldDefault)
                        .cornerRadius(8)
                        
                        RoundedButton(title: "LOGIN") { self.login() }
                    }
                    
                    HStack {
                        Button("Register Now") {self.register()}
                            .foregroundColor(Color.Token.highlight)
                            .sheet(isPresented: self.$viewModel.showRegisterModal) { RegisterView() }
                        Spacer()
                        Button("Forget Password") {self.forgotPassword()}
                            .foregroundColor(Color.Token.inactive)
                    }.padding(.top)

                }.padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
                    .onAppear(perform: self.viewModel.startListener)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .alert(isPresented: self.$viewModel.isErrorShown) {
                Alert(title: Text(self.viewModel.errorMessage))
            }
        }
    }
    
    
    // MARK: - ACTIONS    
    func login() {
        self.viewModel.login(mail: username, password: password)
    }
    func register() {
        self.viewModel.showRegisterModal = true
    }
    func forgotPassword() {
        print("🐞 Forgot Password Pressed")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(FirebaseManager())

    }
}
