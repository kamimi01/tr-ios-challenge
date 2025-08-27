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
        List(viewModel.movies) { movie in
            MovieRowView(movie: movie)
        }
    }
}

#Preview {
    MovieListView()
}
