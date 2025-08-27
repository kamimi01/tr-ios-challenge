//
//  RecommendedMovieListView.swift
//  Movie
//
//  Created by mika_admin on 2025-08-27.
//

import SwiftUI

struct RecommendedMovieListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommendations")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0..<10) { _ in
                        RecommendedMovieCardView(movie: Movie(id: 1, name: "Avengers1", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019),)
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendedMovieListView()
}
