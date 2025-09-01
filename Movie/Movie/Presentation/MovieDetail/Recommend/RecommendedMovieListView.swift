//
//  RecommendedMovieListView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct RecommendedMovieListView: View {
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommendations")
                .font(.title)
                .bold()
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    if movies.isEmpty {
                        Text("No recommendations found")
                            .foregroundStyle(.metaText)
                    } else {
                        ForEach(movies) { movie in
                            NavigationLink {
                                MovieDetailView(id: movie.id, favoriteStore: FavoriteStore())
                            } label: {
                                RecommendedMovieCardView(movie: movie)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendedMovieListView(movies: [Movie(id: 1, name: "avengers", thumbnail: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg", year: 1990)])
}

#Preview {
    RecommendedMovieListView(movies: [])
}
