//
//  OptionRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 29/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

enum SelectableCellStyle: Int, Codable {
    case
    normal,
    button,
    alertButton
}

struct SelectableCell: View {
    @State var title: String = "Title"
    @State var style: SelectableCellStyle
    @State var action: (()->()) = {}

    var body: some View {
        return Button(action: {self.action()}) {
            SelectableCellView(title: title, style: style)
        }.background(Color.white)
        
    }
}

struct SelectableCellView: View {
    @State var title: String = "Title"
    @State var style: SelectableCellStyle = .normal
    
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
                    .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.5))
            }
            .padding(.top)
            .padding(.leading)
            
            Rectangle()
                .frame(height: 1)
                .padding(.leading, 17)
                .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.29))
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
                .frame(height: 1)
                .padding(.leading, 17)
                .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.29))
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
                .frame(height: 1)
                .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.29))
        }
    }
}

#if DEBUG
struct SelectableCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectableCell(style: .alertButton)
    }
}
#endif
