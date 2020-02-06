//
//  KeyboardResponder.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

extension View {

    func keyboardSensible(_ offsetValue: Binding<CGFloat>, extraOffset: CGFloat = 0) -> some View {
    return self
        .padding(.bottom, offsetValue.wrappedValue)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first

                let bottom = keyWindow?.safeAreaInsets.bottom ?? 0

                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height

                offsetValue.wrappedValue = height - bottom + extraOffset
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                offsetValue.wrappedValue = 0
            }
    }
    }
}
