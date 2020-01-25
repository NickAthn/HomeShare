//
//  Seperator.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 25/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct Seperator: View {
    var label: some View = Text("or")
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
            label.padding()
            Rectangle()
                .frame(height: 1)

        }
    }
}

struct Seperator_Previews: PreviewProvider {
    static var previews: some View {
        Seperator()
    }
}
