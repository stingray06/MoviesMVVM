// RepositoryTest.swift
// Copyright © RoadMap. All rights reserved.

//  RepositoryTest.swift
//  moviesTests
//
//  Created by Iurii Kotikhin on 17.10.2021.
//
@testable import movies

import XCTest

final class RepositoryTest: XCTestCase {
    var movie = DescriptionMovie(title: "", overview: "", releaseDate: "", posterPath: "", voteAverage: 0, id: 555)
    var movieID = 580_489
    var movies: [DescriptionMovie] = []
    var category = "Action"
    var repository: RepositoryProtocol!
    var showViewModel: ShowViewModel!
    var aboutViewModel: AboutViewModel!

    override func setUpWithError() throws {
        repository = Repository()
        showViewModel = ShowViewModel()
        aboutViewModel = AboutViewModel(movieID: movieID)
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetMovies() throws {
        showViewModel.fetchMovies(urlMovies: URLType.latestURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }

    func testGetMovie() throws {
        repository.getAboutMovie(type: .realmData, movieID: movieID) { movie in
            self.movie = movie
        }
        XCTAssertEqual(movieID, movie.id)
    }

    func testMovie() throws {
        var numberMovies = Int()
        repository.getMovies(.coreData, urlMovies: URLType.latestURL.rawValue) { result in
            numberMovies = result.count
        }
        XCTAssertNotEqual(numberMovies, 20)
    }

    func testSaveMovies() throws {
        var numberMovies = Int()
        let movies = [
            DescriptionMovie(title: "", overview: "", releaseDate: "", posterPath: "", voteAverage: 0, id: 555)
        ]
        repository.saveMovies(type: .realmData, urlMovies: "Test", movies: movies)
        repository.getMovies(.realmData, urlMovies: "Test") { result in
            numberMovies = result.count
            XCTAssertEqual(numberMovies, 1)
        }
    }

    func testGetMoviesSave() throws {
        showViewModel.saveLoadMovies(urlMovies: URLType.nowPlayingURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }

    func testGetMoviesLoad() throws {
        showViewModel.loadSaveMovies(urlMovies: URLType.upComingURL.rawValue)
        XCTAssertEqual(showViewModel.movie?.count, 20)
    }
}
