//
//  RoundedButton.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

///// Helper function
//private func getOpacityValue(_ isPressed: Bool) -> Double {
//    let isPressedOpacity = 0.8
//    return isPressed ? isPressedOpacity : 1
//}
//
/////
/////
//// MARK: - Token Button
/////
/////
//struct TokenButton {
//    var buttonLabel: TokenButtonLabel
//    var buttonStyle: TokenButtonStyle
//
//    ///
//    // Capsule Button
//    ///
//    private var capsuleBtnText: String! = "Save"
//    /// Capsule Button
//    init(capsuleText: String) {
//        self.capsuleBtnText = capsuleText
//        self.buttonLabel = TokenButtonLabel(text: capsuleText)
//        self.buttonStyle = TokenButtonStyle(backgroundColor: .highlight, textColor: .light)
//    }
//    
//    ///
//    // Text Button
//    ///
//    private var textBtnText: String! = "select"
//    /// Text Button
//    init(buttonText: String) {
//        self.textBtnText = buttonText
//        self.buttonLabel = TokenButtonLabel(text: buttonText)
//        self.buttonStyle = TokenButtonStyle(textColor: .highlight)
//    }
//}
//
//extension TokenButton {
//    /// Global properties
//    enum ButtonType {
//        case capsule, text
//    }
//    enum StateSwitch {
//        case off, on
//    }
//}
/////
/////
//// MARK: - Button Label
/////
/////
//struct TokenButtonLabel: View {
//    /// Global properties
//    private let labelType: LabelTypes
//    
//    /// State properties
//    var isHighlighted = false
//    
//    ///
//    // Text Type
//    ///
//    private var btnText: String?
//    /// Text Type
//    init(text: String) {
//        self.labelType = .text
//        self.btnText = text
//    }
//    
//    /// Helper function
//    func getView() -> some View {
//        var renderView: AnyView!
//        let highlightSuffix = isHighlighted ? "-highlight" : ""
//         
//        switch labelType {
//        case .text:
//            renderView = AnyView(
//                Text("\(btnText!)")
//                    .font(Font.Typography.sizingFont(font: .main, size: .body))
//            )
//        }
//        return renderView
//    }
//    
//    ///
//    // Rendering View
//    ///
//    var body: some View {
//        getView()
//    }
//}
//
//extension TokenButtonLabel {
//    enum LabelTypes {
//        case text
//    }
//    enum TextColor {
//        case highlight, main
//        
//        func getColor() -> Color {
//            switch self {
//            case .highlight:
//                return Color.Token.textHighlight
//            case .main:
//                return Color.Token.textDefault
//            }
//        }
//    }
//}
//
///// State modifier
//extension TokenButtonLabel {
//    /// Pass highlightSwitch argument bonded with @State variable in order to trigger updates
//    mutating func highlight(_ highlightSwitch: TokenButton.StateSwitch) -> Self {
//        self.isHighlighted = highlightSwitch == .on ? true : false
//        return self
//    }
//}
//
//
//
/////
/////
//// MARK: - Button Style
/////
/////
//struct TokenButtonStyle: ButtonStyle {
//    /// Global properties
//    private let styleType: StyleType
//    private var backgroundColor: Color?
//    private var borderStyle: StyleAlias.BorderStyle?
//    private var textColor: Color?
//    
//    /// State properties
//    var isActive = true
//        
//    /// Capsule Button
//    init(backgroundColor: BackgroundColor, textColor: TextColor) {
//        self.styleType = .capsule
//        self.backgroundColor = backgroundColor.getColor()
//        self.textColor = textColor.getColor()
//    }
//    
//    /// Text Button
//    init(textColor: TextColor) {
//        self.styleType = .text
//        self.textColor = textColor.getColor()
//    }
//    
//    /// Rendering Button Style
//    func makeBody(configuration: Self.Configuration) -> some View {
//        var renderView: AnyView!
//        let verticalMargin = CapsuleValue.verticalMargin.rawValue
//        let horizontalMargin = CapsuleValue.horizontalMargin.rawValue
//        
//        switch styleType {
//        case .capsule:
//            renderView = AnyView(configuration.label
//                .padding(.init(top: verticalMargin, leading: horizontalMargin, bottom: verticalMargin, trailing: horizontalMargin))
//                .foregroundColor(textColor!)
//                .background(backgroundColor!)
//                .cornerRadius(horizontalMargin)
//            )
//        case .text:
//            renderView = AnyView(configuration.label
//                .padding(.init(top: verticalMargin, leading: horizontalMargin, bottom: verticalMargin, trailing: horizontalMargin))
//                .foregroundColor(textColor!)
//            )
//        }
//        
//        return renderView.opacity(getOpacityValue(configuration.isPressed || !isActive))
//    }
//}
//
//extension TokenButtonStyle {
//    enum StyleType {
//        case capsule, text
//    }
//    enum MaskShape {
//        case capsule
//    }
//    enum BorderStyle {
//        case regular
//    }
//    enum TextColor {
//        case highlight, light, theme
//        
//        func getColor() -> Color {
//            switch self {
//            case .highlight:
//                return Color.Token.textHighlight
//            case .light:
//                return Color.Token.textLight
//            case .theme:
//                return Color.Token.textTheme
//            }
//        }
//    }
//    enum BackgroundColor {
//        case theme, contrast, clear, highlight
//        
//        func getColor() -> Color {
//            switch self {
//            case .theme:
//                return Color.Token.buttonTheme
//            case .contrast:
//                return Color.Token.buttonContrast
//            case .clear:
//                return Color.clear
//            case .highlight:
//                return Color.Token.buttonHighlight
//            }
//        }
//    }
//    enum CapsuleValue: CGFloat {
//        case height = 44
//        case horizontalMargin = 32
//        case verticalMargin = 16
//    }
//}
//
///// State modifier
//extension TokenButtonStyle {
//    /// Pass highlightSwitch argument bonded with @State variable in order to trigger updates
//    mutating func activate(_ activeSwitch: TokenButton.StateSwitch) -> Self {
//        self.isActive = activeSwitch == .on ? true : false
//        return self
//    }
//}
//

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(BorderlessButtonStyle())
            .padding(10)
            .background(Color.Token.buttonHighlight)
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}
