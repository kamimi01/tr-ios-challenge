//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var detail = MovieDetail(id: 0, name: "", description: "", notes: "", rating: 0.0, picture: "", releaseDate: 0)

    private let id: Int
    private let client = MovieClient()

    init(id: Int) {
        self.id = id
    }

    func load() async {
        do {
            let request = MovieAPI.Detail(id: id)
            self.detail = try await client.send(request: request)
        } catch {
            // FIXME: show an error
        }
    }
}
