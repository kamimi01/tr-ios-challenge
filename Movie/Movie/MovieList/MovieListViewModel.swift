//
//  MovieListViewModel.swift
//  Movie
//
//  Created by mika_admin on 2025-08-26.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = [
        Movie(id: 1, name: "Avengers1", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019),
        Movie(id: 2, name: "Avengers2", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019),
        Movie(id: 3, name: "Avengers3", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019),
        Movie(id: 4, name: "Avengers4", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019),
        Movie(id: 5, name: "Avengers5", thumbnailURL: URL(string: "https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/1.jpg")!, year: 2019)
    ]
}
