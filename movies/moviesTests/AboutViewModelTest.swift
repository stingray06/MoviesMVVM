// AboutViewModelTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import movies

import XCTest

final class AboutViewModelTest: XCTestCase {
    var aboutViewModel: AboutViewModel!
    var movieID = 703_771
    var cell = AboutMovieTableViewCell()
    var indexPath = IndexPath()
    var aboutMovie: DescriptionMovie?

    override func setUpWithError() throws {
        aboutViewModel = AboutViewModel(movieID: movieID)
    }

    override func tearDownWithError() throws {
        aboutViewModel = nil
    }

    func testGetMoviesSave() throws {
        aboutViewModel.fetchDataAboutMovie(cell: cell, indexPath: indexPath, movieID: movieID)

        let number = aboutViewModel.aboutMovie?.id
    }
}
