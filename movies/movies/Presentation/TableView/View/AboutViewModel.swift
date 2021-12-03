// AboutViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AboutViewModelProtocol {
    func fetchDataAboutMovie(cell: AboutMovieTableViewCell, indexPath: IndexPath, movieID: Int)
    func fetchPosterMovie(
        cell: AboutMovieTableViewCell,
        indexPath: IndexPath,
        movieID: Int,
        completion: @escaping (UIImage) -> ()
    )
    var reloadData: (() -> ())? { get set }
    var movieID: Int { get set }
    var aboutMovie: DescriptionMovie? { get set }
}

final class AboutViewModel: AboutViewModelProtocol {
    // MARK: - Public Properties

    var reloadData: (() -> ())?
    var movieID = Int()

    // MARK: - Private Properties

    var aboutMovie: DescriptionMovie?
    private let movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    private let imageAPIService: ImageAPIServiceProtocol = ImageAPIService()
    private let repository: RepositoryProtocol = Repository()
    private let imageService: ImageServiceProtocol = ImageService()

    init(movieID: Int) {
        self.movieID = movieID
    }

    // MARK: - Public Methods

    func fetchDataAboutMovie(cell: AboutMovieTableViewCell, indexPath: IndexPath, movieID: Int) {
        repository.getAboutMovie(type: .realmData, movieID: movieID) { [weak self] data in
            DispatchQueue.main.async {
                cell.aboutMoviesLabel.text = data.overview
                guard let release = data.releaseDate else { return }
                cell.releaseDateLabel.text = "Даты выхода: \(release))"
                guard let mark = data.voteAverage else { return }
                cell.voteLabel.text = "Оценка \(mark)"
                cell.titleMoviesLabel.text = data.title
                self?.aboutMovie = data
                self?.reloadData?()
            }
        }
    }

    func fetchPosterMovie(
        cell: AboutMovieTableViewCell,
        indexPath: IndexPath,
        movieID: Int,
        completion: @escaping (UIImage) -> ()
    ) {
        guard let addresImage = aboutMovie?.posterPath else { return }
        imageService.getImage(addresImage: addresImage) { [weak self] image in
            DispatchQueue.main.async {
                cell.posterMovieImageView.image = image
                completion(image)
                self?.reloadData?()
            }
        }
    }
}
