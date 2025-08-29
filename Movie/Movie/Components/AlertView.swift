//
//  AlertView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import SwiftUI

struct AlertView: ViewModifier {
    @Binding var isShowing: Bool
    let details: AlertDetails

    func body(content: Content) -> some View {
        content
            .alert(details.title, isPresented: $isShowing) {
                ForEach(details.buttons) { button in  // 1
                    Button(role: button.role, action: {
                        button.action?()
                        isShowing = false  // 2
                    }, label: {
                        Text(button.title)
                    })
                    .accessibilityIdentifier(button.accessibilityIdentifier)
                }
            } message: {
                Text(details.message)
            }
    }
}

extension View {
    func showAlert(isShowing: Binding<Bool>, details: AlertDetails) -> some View {
        self.modifier(AlertView(isShowing: isShowing, details: details))
    }
}
