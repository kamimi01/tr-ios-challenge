//
//  MockMovieRepository.swift
//  MovieTests
//
//  Created by mika_admin on 2025-09-01.
//

import Foundation
@testable import Movie

class MockMovieRepository: MovieRepository {
    var fetchMoviesResult: Result<[Movie], Error> = .success([])
    var fetchMovieDetailResult: Result<MovieDetail, Error> = .success(MockData.movieDetail)
    var fetchRecommendedMoviesResult: Result<[Movie], Error> = .success([])
    var favoriteMovieIds: [Int] = []

    var fetchMoviesCallCount = 0
    var fetchMovieDetailCallCount = 0
    var fetchRecommendedMoviesCallCount = 0
    var lastUsedCachePolicy: URLRequest.CachePolicy?
    var lastRequestedMovieId: Int?

    func fetchMovies(cachePolicy: URLRequest.CachePolicy) async throws -> [Movie] {
        fetchMoviesCallCount += 1
        lastUsedCachePolicy = cachePolicy

        switch fetchMoviesResult {
        case .success(let movies):
            return movies
        case .failure(let error):
            throw error
        }
    }

    func fetchMovieDetail(id: Int, cachePolicy: URLRequest.CachePolicy) async throws -> MovieDetail {
        fetchMovieDetailCallCount += 1
        lastRequestedMovieId = id
        lastUsedCachePolicy = cachePolicy

        switch fetchMovieDetailResult {
        case .success(let detail):
            return detail
        case .failure(let error):
            throw error
        }
    }

    func fetchRecommendedMovies(id: Int, cachePolicy: URLRequest.CachePolicy) async throws -> [Movie] {
        fetchRecommendedMoviesCallCount += 1
        lastRequestedMovieId = id
        lastUsedCachePolicy = cachePolicy

        switch fetchRecommendedMoviesResult {
        case .success(let movies):
            return movies
        case .failure(let error):
            throw error
        }
    }

    func fetchFavoriteMovieIds() -> [Int] {
        return favoriteMovieIds
    }

    func saveFavoriteMovieId(_ id: Int) {
        if !favoriteMovieIds.contains(id) {
            favoriteMovieIds.append(id)
        }
    }

    func removeFavoriteMovieId(_ id: Int) {
        if let index = favoriteMovieIds.firstIndex(of: id) {
            favoriteMovieIds.remove(at: index)
        }
    }
}

struct MockData {
    static let movies: [Movie] = [
        Movie(id: 1, name: "Test Movie 1", thumbnail: "thumbnail1.jpg", year: 2023),
        Movie(id: 2, name: "Test Movie 2", thumbnail: "thumbnail2.jpg", year: 2024),
        Movie(id: 3, name: "Test Movie 3", thumbnail: "thumbnail3.jpg", year: 2022)
    ]

    static let movieDetail = MovieDetail(
        id: 1,
        name: "Test Movie 1",
        description: "This is a test movie description",
        notes: "Test notes",
        rating: 8.5,
        picture: "picture1.jpg",
        releaseDate: 1693526400
    )

    static let recommendedMovies: [Movie] = [
        Movie(id: 4, name: "Recommended Movie 1", thumbnail: "rec_thumb1.jpg", year: 2023),
        Movie(id: 5, name: "Recommended Movie 2", thumbnail: "rec_thumb2.jpg", year: 2024)
    ]
}

enum MockError: Error, LocalizedError {
    case testError

    var errorDescription: String? {
        return "Mock test error"
    }
}
