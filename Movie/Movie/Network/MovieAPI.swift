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
    }

    struct Detail: APIRequest {
        typealias Response = MovieDetail

        var path: String = ""
        var method: HttpMethod = .get

        init(id: Int) {
            path = basePath + "/details/\(id).json"
        }
    }

    struct Recommend: APIRequest {
        typealias Response = MovieList

        var path: String = ""
        var method: HttpMethod = .get

        init(id: Int) {
            path = basePath + "/details/recommended/\(id).json"
        }
    }
}
