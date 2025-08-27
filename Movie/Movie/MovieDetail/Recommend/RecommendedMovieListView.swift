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
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    if movies.isEmpty {
                        Text("No recommendations found")
                    } else {
                        ForEach(movies) { movie in
                            RecommendedMovieCardView(movie: movie)
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
