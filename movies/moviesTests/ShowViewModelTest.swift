// ShowViewModelTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import movies

import XCTest

final class ShowViewModelTest: XCTestCase {
    var showViewModel: ShowViewModel!

    override func setUpWithError() throws {
        showViewModel = ShowViewModel()
    }

    override func tearDownWithError() throws {}

    func testGetMoviesSave() throws {
        showViewModel.saveLoadMovies(urlMovies: URLType.nowPlayingURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }

    func testGetMoviesLoad() throws {
        showViewModel.loadSaveMovies(urlMovies: URLType.upComingURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }

    func testGetMovies() throws {
        showViewModel.fetchMovies(urlMovies: URLType.latestURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }
}
