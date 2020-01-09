//
//  StaticForm.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct StaticForm<Content>: View where Content: View  {
    
    let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            content
        }.background(Color.Token.backgroundTheme)
    }
}

struct StaticForm_Previews: PreviewProvider {
    static var previews: some View {
        StaticForm() {
            Text("4")
        }
    }
}

