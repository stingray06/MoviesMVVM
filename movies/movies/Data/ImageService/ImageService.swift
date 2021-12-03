// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ImageServiceProtocol {
    func getImage(addresImage: String, completion: @escaping (UIImage) -> ())
}

final class ImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func getImage(addresImage: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        let cacheImageService = CacheImageService()
        let imageApiService = ImageAPIService()
        let proxy = Proxy(imageAPIService: imageApiService, cacheImageService: cacheImageService)
        proxy.loadImage(url: url) { result in
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
