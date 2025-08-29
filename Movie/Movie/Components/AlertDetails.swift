//
//  AlertDetails.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import SwiftUI

struct AlertDetails {
    let title: String
    let message: String
    let buttons: [AlertButton]
}

struct AlertButton: Identifiable {
    let id = UUID().uuidString
    let title: String
    let role: ButtonRole?
    let action: (() -> Void)?
    let accessibilityIdentifier: String

    init(title: String, role: ButtonRole? = nil, action: (() -> Void)? = nil, accessibilityIdentifier: String = "") {
        self.title = title
        self.role = role
        self.action = action
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}
