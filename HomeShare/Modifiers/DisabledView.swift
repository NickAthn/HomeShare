//
//  DisabledView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct DisabledView: ViewModifier {
    @Binding var isDisabled: Bool
        func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.4 : 1)
    }

}

// Exposing DisabledView function to View
extension View {
    func disabledView(isDisabled: Binding<Bool>) -> some View {
        return modifier(DisabledView(isDisabled: isDisabled))
    }
}
