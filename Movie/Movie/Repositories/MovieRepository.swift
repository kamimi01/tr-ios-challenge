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
    func fetchFavoriteMovieIds() -> [Int]
    func saveFavoriteMovieId(_ id: Int)
    func removeFavoriteMovieId(_ id: Int)
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

    func fetchFavoriteMovieIds() -> [Int] {
        return UserDefaults.standard.array(forKey: Constants.UserDefaultsKey.favoriteMovies) as? [Int] ?? []
    }

    func saveFavoriteMovieId(_ id: Int) {
        var favoriteMovieIds = fetchFavoriteMovieIds()
        if !favoriteMovieIds.contains(id) {
            favoriteMovieIds.append(id)
        }
        UserDefaults.standard.set(favoriteMovieIds, forKey: Constants.UserDefaultsKey.favoriteMovies)
    }

    func removeFavoriteMovieId(_ id: Int) {
        var favoriteMovieIds = fetchFavoriteMovieIds()
        if let index = favoriteMovieIds.firstIndex(of: id) {
            favoriteMovieIds.remove(at: index)
        }
        UserDefaults.standard.set(favoriteMovieIds, forKey: Constants.UserDefaultsKey.favoriteMovies)
    }


}
