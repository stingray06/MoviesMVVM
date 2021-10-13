// ShowModelView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Protocol

protocol ShowModelViewProtocol {
    var json: Movies? { get set }
    var reloadData: (() -> ())? { get set }
    var movies: ((Movies) -> ())? { get set }
    func fetchMovie(urlMovies: URLType)
    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ())
}

final class ShowModelView: ShowModelViewProtocol {
    // MARK: - Public Properties

    var json: Movies?
    var reloadData: (() -> ())?
    var movies: ((Movies) -> ())?
    var urlMovies = URLType.popularURL.rawValue

    // MARK: - Initiation

    init() {
        fetchMovie(urlMovies: URLType.latestURL)
    }

    // MARK: - Public Properties

    func fetchMovie(urlMovies: URLType) {
        guard let url =
            URL(
                string: urlMovies.rawValue
            )
        else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.json = try decoder.decode(Movies.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let movies = self.json else { return }
                    self.movies?(movies)
                    self.reloadData?()
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ()) {
        var image = UIImage()
        guard let addresImage = movie.posterPath else { return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        URLSession.shared.dataTask(with: url) { result, _, _ in
            guard let result = result else { return }
            image = UIImage(data: result) ?? UIImage()
            completion(image)
        }.resume()
    }
}
