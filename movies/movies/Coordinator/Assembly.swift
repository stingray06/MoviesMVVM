// Assembly.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Protocol

protocol AssemblyProtocol {
    func createMainModule() -> UIViewController
    func createDetailModule(movieID: Int) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    // MARK: - Public Methods

    func createMainModule() -> UIViewController {
        let showView = ShowMoviesViewController(showViewModel: ShowViewModel())
        showView.showViewModel?.fetchMovie(urlMovies: URLType.popularURL.rawValue)
        return showView
    }

    func createDetailModule(movieID: Int) -> UIViewController {
        let aboutView = AboutMovieViewController(aboutModelView: AboutViewModel(movieID: movieID))
        return aboutView
    }
}
