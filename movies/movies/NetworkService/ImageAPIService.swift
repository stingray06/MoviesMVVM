// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol ImageAPIServiceProtocol {
    func getImage(addresImage: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public Method

    func getImage(addresImage: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }.resume()
    }
}
