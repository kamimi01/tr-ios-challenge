//
//  MovieListView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @StateObject private var favoriteStore = FavoriteStore()

    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(id: movie.id, favoriteStore: favoriteStore)
                } label: {
                    MovieRowView(movie: movie, favoriteStore: favoriteStore)
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                Task {
                    await viewModel.load()
                }
                favoriteStore.load()
            }
            .showAlert(isShowing: $viewModel.isShowingAlert, details: viewModel.alertDetails)
        }
    }
}

#Preview {
    MovieListView()
}
