//
//  Int+.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation

extension Int {
    func formattedDate(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        return DateFormatter.localizedString(
            from: Date(timeIntervalSince1970: TimeInterval(self)),
            dateStyle: dateStyle,
            timeStyle: timeStyle
        )
    }
}
