//
//  ErrorView.swift
//  Movie
//
//  Created by mika_admin on 2025-09-01.
//

import SwiftUI

struct ErrorView: View {
    let errorDescription: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Something went wrong:\n\(errorDescription)")
                .padding(.top, 150)
                .frame(maxWidth: .infinity)
            Button(action: {
                retry()
            }, label: {
                Text("Retry")
            })
            .foregroundStyle(.tintButton)
        }
    }
}

extension APIRequestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        }
    }
}

extension MovieClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .connectionFailed:
            return "We couldn’t connect to the server."
        case .badRequest:
            return "The request was invalid."
        case .badServerResponse:
            return "The server encountered an error."
        case .unexpectedResponse(let code):
            return "Unexpected server response (\(code))."
        }
    }
}

#Preview {
    ErrorView(errorDescription: MovieClientError.unexpectedResponse(statusCode: 0).userMessage, retry: {
        print("retry")
    })
}
