// ShowViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Protocol

protocol ShowViewModelProtocol {
    var movie: [DescriptionMovie]? { get set }
    var reloadData: (() -> ())? { get set }
    func fetchMovies(urlMovies: String)
}

final class ShowViewModel: ShowViewModelProtocol {
    // MARK: - Public Properties

    var movie: [DescriptionMovie]?
    var reloadData: (() -> ())?
    var urlMovies = URLType.popularURL.rawValue

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    private let repository: RepositoryProtocol = Repository()

    // MARK: - Initiation

    init() {
        fetchMovies(urlMovies: URLType.latestURL.rawValue)
    }

    // MARK: - Public Properties

    func loadSaveMovies(urlMovies: String) {
        movieAPIService.getData(type: Movies.self, url: urlMovies) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self?.repository.saveMovies(type: .realmData, urlMovies: urlMovies, movies: data.results)
                    self?.repository.getMovies(.realmData, urlMovies: urlMovies) { [weak self] movies in
                        self?.movie = movies
                    }
                    self?.reloadData?()
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func saveLoadMovies(urlMovies: String) {
        repository.getMovies(.realmData, urlMovies: urlMovies) { [weak self] movies in
            if movies.isEmpty {
                self?.movieAPIService.getData(type: Movies.self, url: urlMovies) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case let .success(data):
                            self?.repository.saveMovies(
                                type: .realmData,
                                urlMovies: urlMovies,
                                movies: data.results
                            )
                            self?.repository.getMovies(.realmData, urlMovies: urlMovies) { [weak self] movies in
                                self?.movie = movies
                            }
                            self?.reloadData?()
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
            }
            self?.movie = movies
        }
        reloadData?()
    }

    func fetchMovies(urlMovies: String) {
        var moviesLoad: [DescriptionMovie] = []
        repository.getMovies(.realmData, urlMovies: urlMovies) { movies in
            moviesLoad = movies
        }
        if moviesLoad.isEmpty {
            loadSaveMovies(urlMovies: urlMovies)
        } else {
            saveLoadMovies(urlMovies: urlMovies)
        }
    }
}
