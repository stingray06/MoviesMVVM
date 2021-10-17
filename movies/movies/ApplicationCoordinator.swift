// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Method

    override func start() {
        toMain()
    }

    // MARK: - Private methods

    private func toMain() {
        let coordinator = MoviesCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
