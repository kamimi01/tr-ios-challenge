//
//  MovieAPI.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

final class MovieAPI {
    private static let basePath: String = "/TradeRev/tr-ios-challenge/master"

    struct List: APIRequest {
        typealias Response = MovieList

        var path: String = basePath + "/list.json"
        var method: HttpMethod = .get
        var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy

        init(cachePolicy: URLRequest.CachePolicy) {
            self.cachePolicy = cachePolicy
        }
    }

    struct Detail: APIRequest {
        typealias Response = MovieDetail

        var path: String = ""
        var method: HttpMethod = .get
        var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy

        init(id: Int, cachePolicy: URLRequest.CachePolicy) {
            path = basePath + "/details/\(id).json"
            self.cachePolicy = cachePolicy
        }
    }

    struct Recommend: APIRequest {
        typealias Response = MovieList

        var path: String = ""
        var method: HttpMethod = .get
        var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy

        init(id: Int, cachePolicy: URLRequest.CachePolicy) {
            path = basePath + "/details/recommended/\(id).json"
            self.cachePolicy = cachePolicy
        }
    }
}
