//
//  ColorPalette.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

///
// MARK: Base color palette materials
///

/// 1. Level 2 base
struct BaseColor {
    /// Dynamic color sets (with dark and light mode)
    let contrastPrimary = Color("contrastPrimary")
    let contrastSecondary = Color("contrastSecondary")
    let themePrimary = Color("themePrimary")
    let themeSecondary = Color("themeSecondary")
    let brandPrimary = Color("brandPrimary")
    
    /// Static color sets (not updating along with color mode)
    let darkPrimary = Color("darkPrimary")
    let lightPrimary = Color("lightPrimary")
    let gray = Color("gray")
    let lightGray = Color("lightGray")

}

/// 2. Level 3 tokens
struct TokenColor {
    let baseColor = BaseColor()
    
    let highlight: Color!
    let inactive: Color!
    
    let textDefault: Color!
    let textTheme: Color!
    let textNote: Color!
    let textHighlight: Color!
    let textLight: Color!
    
    let buttonTheme: Color!
    let buttonContrast: Color!
    let buttonHighlight: Color!
    
    let backgroundDefault: Color!
    let backgroundTheme: Color!
    
    let fieldDefault: Color!
    
    init() {
        /// themePrimary
        self.textTheme = baseColor.themePrimary
        self.buttonTheme = baseColor.themePrimary
        self.backgroundTheme = baseColor.themePrimary
        
        /// themeSecondary
        self.textNote = baseColor.themeSecondary
        
        /// contrastPrimary
        self.buttonContrast = baseColor.contrastPrimary
        self.textDefault = baseColor.contrastPrimary
        self.backgroundDefault = baseColor.contrastPrimary
        
        /// brand
        self.highlight = baseColor.brandPrimary
        self.buttonHighlight = baseColor.brandPrimary
        self.textHighlight = baseColor.brandPrimary
        
        /// lightPrimary
        self.textLight = baseColor.lightPrimary
        
        /// gray
        self.inactive = baseColor.gray
        
        /// lightGray
        self.fieldDefault = baseColor.lightGray
    }
}

///
// MARK: Add palatte to Color struct
///
///
/// Base colors are not exposed at same layer as Color.Token but inside of which,
/// because we encourage using Token colors instead of Base colors in most cases.
///
extension Color {
    static let Token = TokenColor()
}


