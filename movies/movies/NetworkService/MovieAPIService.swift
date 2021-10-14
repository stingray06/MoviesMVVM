// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol MovieAPIServiceProtocol {
    func getData<T: Decodable>(type: T.Type, url: URL, completion: @escaping (Result<T, Error>) -> ())
    var beginURL: String { get }
    var endURL: String { get }
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Public Properties

    var beginURL = "https://api.themoviedb.org/3/movie/"
    var endURL = "?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU"

    // MARK: - Public Method

    func getData<T: Decodable>(type: T.Type, url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(T.self, from: data)
                completion(.success(movies))
            } catch {
                print(error)
            }
        }.resume()
    }
}
