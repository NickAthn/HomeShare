//
//  TaskRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    var task: Task
    @State var showSheet: Bool = false
    
    var body: some View {
        HStack{
            task.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35)
                .foregroundColor(task.color)
            VStack(alignment: .leading){
                Text(task.title).font(.headline)
                Text(task.desc).font(.subheadline)
            }
            Spacer()
        }
        .onTapGesture {
            self.shouldShowSheet()
        }
        .sheet(isPresented: $showSheet) {
            self.getSheet()
        }
    }
    
    func shouldShowSheet() {
        if (SystemTaskID(rawValue: task.id) != nil) {
            showSheet.toggle()
        }
    }
    
    func getSheet() -> AnyView{
        switch task.id {
            case "verificationNeeded": return AnyView(VerifyAccountView())
            default: return AnyView(EmptyView())
        }
    }
    
}
