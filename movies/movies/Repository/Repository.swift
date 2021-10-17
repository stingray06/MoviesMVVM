// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
// Выбор хранилища
enum RepositoryType {
    case realmData, coreData
}

protocol RepositoryProtocol {
    func getMovies(_ type: RepositoryType, urlMovies: String, _ completion: @escaping (([DescriptionMovie]) -> Void))
    func saveMovies(type: RepositoryType, urlMovies: String, movies: [DescriptionMovie])
    func getAboutMovie(type: RepositoryType, movieID: Int, completion: @escaping ((DescriptionMovie) -> Void))
}

final class Repository: RepositoryProtocol {
    // MARK: - Private Properties

    private var realmData: RealmDataProtocol = RealmData()

    // MARK: - Public Methods

    func getMovies(_ type: RepositoryType, urlMovies: String, _ completion: @escaping (([DescriptionMovie]) -> Void)) {
        switch type {
        case .realmData:
            let movies = realmData.getMovies(urlMovies: urlMovies)
            completion(movies)
        case .coreData:
            return
        }
    }

    func saveMovies(type: RepositoryType, urlMovies: String, movies: [DescriptionMovie]) {
        switch type {
        case .realmData:
            realmData.saveMovies(category: urlMovies, movies: movies)
        case .coreData:
            return
        }
    }

    func getAboutMovie(type: RepositoryType, movieID: Int, completion: @escaping ((DescriptionMovie) -> Void)) {
        switch type {
        case .realmData:
            let movie = realmData.getAboutMovie(movieID: movieID)
            completion(movie)
        case .coreData:
            return
        }
    }
}
