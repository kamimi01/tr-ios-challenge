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
                    MovieDetailView(movie: movie)
                } label: {
                    MovieRowView(movie: movie)
                }
            }
        }
    }
}

#Preview {
    MovieListView()
}
