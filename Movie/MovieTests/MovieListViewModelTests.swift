//
//  MovieListViewModelTests.swift
//  MovieTests
//
//  Created by mika_admin on 2025-09-01.
//

import XCTest
@testable import Movie

@MainActor
final class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var mockRepository: MockMovieRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        sut = MovieListViewModel(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func testInitialState() {
        // Arrange
        // Initial state is set during initialization

        // Act
        let initialState = sut.uiState

        // Assert
        if case .initial = initialState {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected initial state, got \(initialState)")
        }
    }

    func testLoadMoviesSuccessWithCache() async {
        // Arrange
        let expectedMovies = MockData.movies
        mockRepository.fetchMoviesResult = .success(expectedMovies)

        // Act
        await sut.load(isRefresh: false)

        // Assert
        if case .loaded(let movies) = sut.uiState {
            XCTAssertEqual(movies.count, expectedMovies.count)
            XCTAssertEqual(movies[0].id, expectedMovies[0].id)
            XCTAssertEqual(movies[0].name, expectedMovies[0].name)
            XCTAssertEqual(mockRepository.fetchMoviesCallCount, 1)
            XCTAssertEqual(mockRepository.lastUsedCachePolicy, .returnCacheDataElseLoad)
        } else {
            XCTFail("Expected loaded state with movies, got \(sut.uiState)")
        }
    }

    func testLoadMoviesSuccessWithRefresh() async {
        // Arrange
        let expectedMovies = MockData.movies
        mockRepository.fetchMoviesResult = .success(expectedMovies)

        // Act
        await sut.load(isRefresh: true)

        // Assert
        if case .loaded(let movies) = sut.uiState {
            XCTAssertEqual(movies.count, expectedMovies.count)
            XCTAssertEqual(mockRepository.fetchMoviesCallCount, 1)
            XCTAssertEqual(mockRepository.lastUsedCachePolicy, .reloadRevalidatingCacheData)
        } else {
            XCTFail("Expected loaded state with movies, got \(sut.uiState)")
        }
    }

    func testLoadMoviesFailure() async {
        // Arrange
        mockRepository.fetchMoviesResult = .failure(MockError.testError)

        // Act
        await sut.load(isRefresh: false)

        // Assert
        if case .error(let error) = sut.uiState {
            XCTAssertTrue(error is MockError)
            XCTAssertEqual((error as? MockError), MockError.testError)
            XCTAssertEqual(mockRepository.fetchMoviesCallCount, 1)
        } else {
            XCTFail("Expected error state, got \(sut.uiState)")
        }
    }
}
