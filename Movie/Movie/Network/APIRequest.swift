//
//  APIRequest.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
}

protocol APIRequest {
    associatedtype Response: Codable

    var baseURL: URL { get }
    var path: String { get set }
    var method: HttpMethod { get set }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension APIRequest {
    var baseURL: URL {
        URL(string: "https://raw.githubusercontent.com")!
    }

    var cachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }

    func buildAPIRequest() throws -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = path

        guard let url = components?.url
        else { throw APIRequestError.invalidURL }

        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy)
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
