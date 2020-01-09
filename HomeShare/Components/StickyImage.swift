//
//  StickyImageView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 28/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct StickyImage: View{
//    var headerHeight: CGFloat = 300
    var image: Image = Image("exampleImage")

    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .global).minY <= 0 {
                self.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY/9)
                    .clipped()
            } else {
                self.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
            }
        }
    }
}

extension Image {
    
}
