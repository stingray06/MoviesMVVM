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
}

final class AboutViewModel: AboutViewModelProtocol {
    // MARK: - Public Properties

    var reloadData: (() -> ())?
    var movieID = Int()

    // MARK: - Private Properties

    private var aboutMovie: DescriptionMovie?
    private let movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    private let imageAPIService: ImageAPIServiceProtocol = ImageAPIService()

    init(movieID: Int) {
        self.movieID = movieID
    }

    // MARK: - Public Methods

    func fetchDataAboutMovie(cell: AboutMovieTableViewCell, indexPath: IndexPath, movieID: Int) {
        guard let url = URL(string: movieAPIService.beginURL + "\(movieID)" + movieAPIService.endURL) else { return }
        movieAPIService.getData(type: DescriptionMovie.self, url: url) { (result: Result<DescriptionMovie, Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(data):
                    guard let self = self else { return }
                    cell.aboutMoviesLabel.text = data.overview
                    guard let release = data.releaseDate else { return }
                    cell.releaseDateLabel.text = "Даты выхода: \(release))"
                    guard let mark = data.voteAverage else { return }
                    cell.voteLabel.text = "Оценка \(mark)"
                    cell.titleMoviesLabel.text = data.title
                    self.aboutMovie = data
                    self.reloadData?()
                case let .failure(error):
                    print(error)
                }
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
        imageAPIService.getImage(addresImage: addresImage) { (result: Result<UIImage, Error>) in
            switch result {
            case let .success(image):
                cell.posterMovieImageView.image = image
                self.reloadData?()
            case let .failure(error):
                print(error)
            }
        }
    }
}
