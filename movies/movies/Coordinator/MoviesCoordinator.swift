// MoviesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MoviesCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController!
    var onFinishFlow: (() -> ())?
    let assembly = Assembly()

    // MARK: - Init

    convenience init(rootController: UINavigationController) {
        self.init()
        self.rootController = rootController
    }

    // MARK: - Public Method

    override func start() {
        showMoviesScreen()
    }

    func showAboutMovie(movieID: Int) {
        let aboutView = assembly.createDetailModule(movieID: movieID)
        rootController?.pushViewController(aboutView, animated: true)
    }

    // MARK: - Private Method

    private func showMoviesScreen() {
        guard let showView = assembly.createMainModule() as? ShowMoviesViewController else { return }
        showView.transitMovieID = { result in self.showAboutMovie(movieID: result) }
        switch rootController {
        case nil:
            let navigationController = UINavigationController(rootViewController: showView)
            rootController = navigationController
            setAsRoot(navigationController)
        default:
            rootController?.pushViewController(showView, animated: true)
            guard let rootController = rootController else { return }
            setAsRoot(rootController)
        }
    }
}
