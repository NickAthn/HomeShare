//
//  LoadingView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading Account")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                .shadow(radius: 20)

            }
        }
    }

}
