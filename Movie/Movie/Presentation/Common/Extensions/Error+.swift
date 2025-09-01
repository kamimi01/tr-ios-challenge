//
//  Error+.swift
//  Movie
//
//  Created by mika_admin on 2025-09-01.
//

import Foundation

extension Error {
    var userMessage: String {
        if let localizedError = self as? LocalizedError,
           let message = localizedError.errorDescription {
            return message
        }
        return (self as NSError).localizedDescription
    }
}
