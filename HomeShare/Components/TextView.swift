//
//  TextView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 24/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct TextView: View {
    @Binding var text: String
    var placeholder: String = ""

    var body: some View {
        TextViewRepresentable(text: $text, placeholder: placeholder)
            .offset(x: -3.5)
    }
}
struct TextViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    internal var placeholderLabel: UILabel = UILabel()
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator

        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true

        view.backgroundColor = Color.Token.fieldDefault.uiColor()
        view.font = UIFont.systemFont(ofSize: 17)
 
        // Placeholder
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 17)
        placeholderLabel.sizeToFit()
        view.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (view.font?.pointSize)! / 2)
        placeholderLabel.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        placeholderLabel.isHidden = !view.text.isEmpty
        
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> TextViewRepresentable.Coordinator {
        Coordinator(self, placeholderLabel)
    }

    class Coordinator : NSObject, UITextViewDelegate {
        var placeholderLabel: UILabel
        var parent: TextViewRepresentable

        init(_ uiTextView: TextViewRepresentable, _ placeholderLabel: UILabel) {
            self.parent = uiTextView
            self.placeholderLabel = placeholderLabel
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            placeholderLabel.isHidden = !textView.text.isEmpty
            self.parent.text = textView.text
        }
    }
}
