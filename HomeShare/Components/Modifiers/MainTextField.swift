//
//  RoundedTextFieldModifier.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 24/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct MainTextField: ViewModifier {
        func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.Token.fieldDefault)
            .cornerRadius(8)
    }
}
