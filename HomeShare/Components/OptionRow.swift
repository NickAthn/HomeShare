//
//  OptionRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 29/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

enum OptionRowStyle: Int, Codable {
    case
    normal,
    button,
    alertButton
}

struct OptionRow<Content: View>: View {
    @State var destination: Content
    @State var title: String = "Title"
    @State var style: OptionRowStyle

    var body: some View {
        return NavigationLink(destination: self.destination) {
            OptionView(title: title, style: style)
        }.background(Color.white)
    }
}

struct OptionView: View {
    @State var title: String = "Title"
    @State var style: OptionRowStyle = .normal
    
    var body: some View {
        switch style {
            case .normal:
                return AnyView(NormalView(title: title))
            case .button:
                return AnyView(ButtonView(title: title))
            case .alertButton:
                return AnyView(AlertButtonView(title: title))
            default:
                return AnyView(EmptyView())
        }
    }
}

fileprivate struct NormalView: View {
    var title: String = "Title"
    
    var body: some View {
        VStack {
            HStack {
//                Image("exampleImage")
//                    .resizable()
//                    .cornerRadius(12)
//                    .frame(width: 25, height: 25)
//                    .clipped()
//                    .aspectRatio(contentMode: .fit)
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(.trailing)
                    .foregroundColor(.gray)
            }
            .padding(.top)
            .padding(.leading)
            
            Rectangle()
                .frame(height: 0.5)
                .padding(.leading, 17)
                .foregroundColor(.gray)
        }
    }

}

fileprivate struct ButtonView: View {
    @State var title: String = "Title"
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Rectangle()
                .frame(height: 0.5)
                .padding(.leading, 17)
                .foregroundColor(.gray)
        }
    }
}

fileprivate struct AlertButtonView: View {
    @State var title: String = "Title"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.red)
                    .font(.system(size: 18))
            }
            .padding(.top)
            .padding(.leading)
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray)
        }
    }
}

#if DEBUG
struct OptionRow_Previews: PreviewProvider {
    static var previews: some View {
        OptionRow(destination: Text("Debuging View"), style: .alertButton)
    }
}
#endif

