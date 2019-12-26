//
//  DashboardView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 9/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let desc: String
    
    let isDone: Bool = false
}
struct DashboardView: View {
    let todoList = [
        Task(image: Image("logo"), title: "Confirm Mail", desc: "You have to confirm your email"),
        Task(image: Image("logo"), title: "Confirm Mail", desc: "You have to confirm your email")
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("To - Do")
                    .padding(.leading)
                    .font(Font.system(.headline))
                List(todoList) { task in
                    HStack{
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack(alignment: .leading){
                            Text(task.title)
                            Text(task.desc)
                        }
                    }.frame(minWidth: .none, idealWidth: .infinity, maxWidth: .infinity, minHeight: 34, idealHeight: 50, maxHeight: 70, alignment: .leading)
                }
            }
            
            Text("Upcoming Travels")
            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

