// ShowViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Protocol

protocol ShowViewModelProtocol {
    var movie: [DescriptionMovie]? { get set }
    var reloadData: (() -> ())? { get set }
    func fetchMovie(urlMovies: String)
    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ())
}

final class ShowViewModel: ShowViewModelProtocol {
    // MARK: - Public Properties

    var movie: [DescriptionMovie]?
    var reloadData: (() -> ())?
    var urlMovies = URLType.popularURL.rawValue

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    private let imageAPIService: ImageAPIServiceProtocol = ImageAPIService()
    private let imageService: ImageServiceProtocol = ImageService()
    private let repository: RepositoryProtocol = Repository()

    // MARK: - Initiation

    init() {
        fetchMovie(urlMovies: URLType.latestURL.rawValue)
    }

    // MARK: - Public Properties

    func fetchMovie(urlMovies: String) {
        repository.getMovies(.realmData, urlMovies: urlMovies) { movies in
            if movies.isEmpty {
                //   guard let url = URL(string: urlMovies) else { return }
                self.movieAPIService.getData(type: Movies.self, url: urlMovies) { [weak self] result in
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
            } else {
                self.repository.getMovies(.realmData, urlMovies: urlMovies) { [weak self] movies in
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
                self.reloadData?()
            }
        }
    }

    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ()) {
        guard let addresImage = movie.posterPath else { return }
        imageService.getImage(addresImage: addresImage) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
