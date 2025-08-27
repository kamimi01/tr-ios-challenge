//
//  MovieClient.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

enum MovieClientError: Error {
    case connectionFailed
    case unexpectedResponse(statusCode: Int)
}

final class MovieClient {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    private let decorder: JSONDecoder = {
        var decoder = JSONDecoder()
        return decoder
    }()

    func send<Request: APIRequest>(request: Request) async throws -> Request.Response {
        let urlRequest = try request.buildAPIRequest()

        let (data, response) = try await session.data(for: urlRequest)

        try validate(data: data, response: response)

        return try decorder.decode(Request.Response.self, from: data)
    }

    private func validate(data: Data, response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw MovieClientError.connectionFailed
        }

        if !(200...299).contains(statusCode) {
            throw MovieClientError.unexpectedResponse(statusCode: statusCode)
        }
    }
}
