//
//  MovieRepository.swift
//  Movie
//
//  Created by mika_admin on 2025-08-29.
//

import Foundation

protocol MovieRepository {
    func fetchMovies() async throws -> [Movie]
    func fetchMovieDetail(id: Int) async throws -> MovieDetail
    func fetchRecommendedMovies(id: Int) async throws -> [Movie]
}

final class MovieRepositoryImpl: MovieRepository {
    private let apiClient = MovieClient()

    func fetchMovies() async throws -> [Movie] {
        let request = MovieAPI.List()
        let list = try await apiClient.send(request: request)
        return list.movies
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let detailRequest = MovieAPI.Detail(id: id)
        return try await apiClient.send(request: detailRequest)
    }

    func fetchRecommendedMovies(id: Int) async throws -> [Movie] {
        let recommendedRequest = MovieAPI.Recommend(id: id)
        let recommendedList = try await apiClient.send(request: recommendedRequest)
        return recommendedList.movies
    }
}
