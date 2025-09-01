//
//  MovieDetailViewModelTests.swift
//  MovieTests
//
//  Created by mika_admin on 2025-09-01.
//

import XCTest
@testable import Movie

@MainActor
final class MovieDetailViewModelTests: XCTestCase {
    var sut: MovieDetailViewModel!
    var mockRepository: MockMovieRepository!
    let testMovieId = 123

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        sut = MovieDetailViewModel(id: testMovieId, repository: mockRepository)
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
        let movieId = sut.id

        // Assert
        if case .initial = initialState {
            XCTAssertTrue(true)
            XCTAssertEqual(movieId, testMovieId)
        } else {
            XCTFail("Expected initial state, got \(initialState)")
        }
    }

    func testLoadMovieDetailAndRecommendedSuccessWithCache() async {
        // Arrange
        let expectedDetail = MockData.movieDetail
        let expectedRecommended = MockData.recommendedMovies
        mockRepository.fetchMovieDetailResult = .success(expectedDetail)
        mockRepository.fetchRecommendedMoviesResult = .success(expectedRecommended)

        // Act
        await sut.load(isRefresh: false)

        // Assert
        if case .loaded(let detail, let recommended) = sut.uiState {
            XCTAssertEqual(detail.id, expectedDetail.id)
            XCTAssertEqual(detail.name, expectedDetail.name)
            XCTAssertEqual(detail.description, expectedDetail.description)
            XCTAssertEqual(detail.rating, expectedDetail.rating)
            XCTAssertEqual(recommended.count, expectedRecommended.count)
            XCTAssertEqual(recommended[0].id, expectedRecommended[0].id)

            XCTAssertEqual(mockRepository.fetchMovieDetailCallCount, 1)
            XCTAssertEqual(mockRepository.fetchRecommendedMoviesCallCount, 1)
            XCTAssertEqual(mockRepository.lastRequestedMovieId, testMovieId)
            XCTAssertEqual(mockRepository.lastUsedCachePolicy, .returnCacheDataElseLoad)
        } else {
            XCTFail("Expected loaded state with detail and recommended movies, got \(sut.uiState)")
        }
    }

    func testLoadMovieDetailAndRecommendedSuccessWithRefresh() async {
        // Arrange
        let expectedDetail = MockData.movieDetail
        let expectedRecommended = MockData.recommendedMovies
        mockRepository.fetchMovieDetailResult = .success(expectedDetail)
        mockRepository.fetchRecommendedMoviesResult = .success(expectedRecommended)

        // Act
        await sut.load(isRefresh: true)

        // Assert
        if case .loaded(let detail, let recommended) = sut.uiState {
            XCTAssertEqual(detail.id, expectedDetail.id)
            XCTAssertEqual(recommended.count, expectedRecommended.count)
            XCTAssertEqual(mockRepository.lastUsedCachePolicy, .reloadRevalidatingCacheData)
        } else {
            XCTFail("Expected loaded state, got \(sut.uiState)")
        }
    }

    func testLoadMovieDetailFailure() async {
        // Arrange
        mockRepository.fetchMovieDetailResult = .failure(MockError.testError)
        mockRepository.fetchRecommendedMoviesResult = .success(MockData.recommendedMovies)

        // Act
        await sut.load(isRefresh: false)

        // Assert
        if case .error(let error) = sut.uiState {
            XCTAssertTrue(error is MockError)
            XCTAssertEqual((error as? MockError), MockError.testError)
            XCTAssertEqual(mockRepository.fetchMovieDetailCallCount, 1)
            XCTAssertEqual(mockRepository.fetchRecommendedMoviesCallCount, 0) // Should not fetch recommended if detail fails
        } else {
            XCTFail("Expected error state, got \(sut.uiState)")
        }
    }

    func testLoadRecommendedMoviesFailure() async {
        // Arrange
        mockRepository.fetchMovieDetailResult = .success(MockData.movieDetail)
        mockRepository.fetchRecommendedMoviesResult = .failure(MockError.testError)

        // Act
        await sut.load(isRefresh: false)

        // Assert
        if case .error(let error) = sut.uiState {
            XCTAssertTrue(error is MockError)
            XCTAssertEqual((error as? MockError), MockError.testError)
            XCTAssertEqual(mockRepository.fetchMovieDetailCallCount, 1)
            XCTAssertEqual(mockRepository.fetchRecommendedMoviesCallCount, 1)
        } else {
            XCTFail("Expected error state, got \(sut.uiState)")
        }
    }

    func testReleaseDateStringFormatting() {
        // Arrange
        let timestamp = 1693526400 // September 1, 2023 00:00:00 GMT

        // Act
        let dateString = sut.releaseDateString(from: timestamp)

        // Assert
        XCTAssertFalse(dateString.isEmpty)
        // The exact format depends on the locale, but it should contain year
        XCTAssertTrue(dateString.contains("2023") || dateString.contains("23"))
    }
}
