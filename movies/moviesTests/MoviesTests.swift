// MoviesTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import movies

import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

final class MoskAboutViewModel: AboutViewModelProtocol {
    func fetchDataAboutMovie(cell: AboutMovieTableViewCell, indexPath: IndexPath, movieID: Int) {}
    func fetchPosterMovie(
        cell: AboutMovieTableViewCell,
        indexPath: IndexPath,
        movieID: Int,
        completion: @escaping (UIImage) -> ()
    ) {}
    var reloadData: (() -> ())?
    var movieID = 333
    var aboutViewModel: AboutViewModel?
    var aboutMovie: DescriptionMovie?
}

final class MoviesTests: XCTestCase {
    var aboutViewModel = MoskAboutViewModel()
    var navController = MockNavigationController()
    var moviesCoordinator: MoviesCoordinator?
    override func setUpWithError() throws {
        moviesCoordinator = MoviesCoordinator(rootController: navController)
    }

    override func tearDownWithError() throws {
        moviesCoordinator = nil
    }

    func testMovies() throws {
        moviesCoordinator?.start()
        let moviesController = navController.presentedVC
        XCTAssertTrue(moviesController is ShowMoviesViewController)
    }

    func testAboutMovies() throws {
        guard let showView = navController.presentedVC as? ShowMoviesViewController else { return }
        showView.transitMovieID?(333)
        let aboutView = navController.presentedVC
        XCTAssertTrue(aboutView is AboutMovieViewController)
    }

    func testAboutMoviesID() throws {
        let movieID = 333
        guard let showView = navController.presentedVC as? ShowMoviesViewController else { return }
        showView.transitMovieID?(movieID)
        showView.transitMovieID = { [weak self] result in self?.moviesCoordinator?.showAboutMovie(movieID: result) }
        XCTAssertEqual(movieID, aboutViewModel.movieID)
    }
}
