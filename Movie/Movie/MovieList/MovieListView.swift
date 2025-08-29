//
//  MovieListView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(id: movie.id)
                } label: {
                    MovieRowView(movie: movie, favoriteMovieIds: viewModel.favoriteMovieIds)
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}

#Preview {
    MovieListView()
}
