//
//  SubmitTicketView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct SubmitTicketView: View {
    @State var subject: String = ""
    @State var message: String = ""
    @State private var offsetValue: CGFloat = 0.0
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Subject")
                TextField("Chating, App Issue, Inappropriate User etc...", text: self.$subject)
                    .modifier(MainTextField())
                
                Text("Message")
                TextView(text: self.$message, placeholder: "Describe your issue in detail here.")
                    .frame(height: 300)
                    .modifier(MainTextField())

            }
            .padding()

        }
        .navigationBarTitle("Submit your ticket")
        .resignKeyboardOnDragGesture()
        .navigationBarItems(trailing: Button(action: self.sendTicket) {
            Text("Send")
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Required field is empty"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func sendTicket(){
        if subject == "" {
            alertMessage = "Please fill the subject field in order to send the ticket."
            showAlert = true
            return
        }
        if message == "" {
            alertMessage = "Please fill the message field in order to send the ticket."
            showAlert = true
            return
        }
        
        FirebaseService.shared.submitTicket(subject: subject, message: message)
    }
}

struct SubmitTicketView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitTicketView()
    }
}
