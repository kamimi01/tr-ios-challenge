//
//  MovieRowView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct MovieRowView: View {
    @ObservedObject private var favoriteStore: FavoriteStore

    let movie: Movie

    init(movie: Movie, favoriteStore: FavoriteStore) {
        self.movie = movie
        self.favoriteStore = favoriteStore
    }

    var body: some View {
        HStack(spacing: 15) {
            Group {
                if let thumbnailUrl = URL(string: movie.thumbnail) {
                    AsyncImage(url: thumbnailUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "movieclapper")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                }
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 10) {
                Text(movie.name)
                    .font(.body)
                Text(verbatim: "(\(movie.year))")
                    .font(.caption)
                    .foregroundStyle(.metaText)
            }

            Spacer()

            Button(action: {
                favoriteStore.toggleFavorite(movie.id)
            }, label: {
                Image(systemName: favoriteStore.isFavorite(movie.id) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(favoriteStore.isFavorite(movie.id) ? .heart : .metaText)
            })
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie(id: 0, name: "avengers", thumbnail: "", year: 1990), favoriteStore: FavoriteStore())
}
