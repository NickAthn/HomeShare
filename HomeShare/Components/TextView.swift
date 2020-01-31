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

struct TextView: UIViewRepresentable {
    
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator

        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true

        view.backgroundColor = Color.Token.fieldDefault.uiColor()
        view.font = UIFont.systemFont(ofSize: 17)
        
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
    

}
