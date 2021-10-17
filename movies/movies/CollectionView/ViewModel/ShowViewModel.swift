// ShowViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Protocol

protocol ShowViewModelProtocol {
    var movie: Movies? { get set }
    var reloadData: (() -> ())? { get set }
    func fetchMovie(urlMovies: URLType)
    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ())
}

final class ShowViewModel: ShowViewModelProtocol {
    // MARK: - Public Properties

    var movie: Movies?
    var reloadData: (() -> ())?
    var urlMovies = URLType.popularURL.rawValue

    // MARK: - Private Properties

    private let movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    private let imageAPIService: ImageAPIServiceProtocol = ImageAPIService()

    // MARK: - Initiation

    init() {
        fetchMovie(urlMovies: URLType.latestURL)
    }

    // MARK: - Public Properties

    func fetchMovie(urlMovies: URLType) {
        guard let url = URL(string: urlMovies.rawValue) else { return }
        movieAPIService.getData(type: Movies.self, url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self?.movie = data
                    self?.reloadData?()
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ()) {
        guard let addresImage = movie.posterPath else { return }
        imageAPIService.getImage(addresImage: addresImage) { result in
            switch result {
            case let .success(dataImage):
                completion(dataImage)
            case let .failure(error):
                print(error)
            }
        }
    }
}
