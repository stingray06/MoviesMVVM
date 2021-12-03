// APITest.swift
// Copyright © RoadMap. All rights reserved.

@testable import movies

import XCTest

final class MovieAPITest: XCTestCase {
    var showViewModel: ShowViewModel!
    var movieAPIService: MovieAPIService!
    var imageService: ImageService!
    var imageAPIService: ImageAPIService!

    override func setUpWithError() throws {
        showViewModel = ShowViewModel()
        movieAPIService = MovieAPIService()
        imageService = ImageService()
        imageAPIService = ImageAPIService()
    }

    override func tearDownWithError() throws {
        showViewModel = nil
        movieAPIService = nil
        imageService = nil
        imageAPIService = nil
    }

    func testExample() throws {
        var collectioMovies: [DescriptionMovie] = []
        movieAPIService.getData(type: Movies.self, url: URLType.latestURL.rawValue) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(movies):
                    collectioMovies = movies.results
                    XCTAssertEqual(collectioMovies.count, 20)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func testMovie() throws {
        let url = "https://api.themoviedb.org/3/movie/550998?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU"
        movieAPIService.getData(type: DescriptionMovie.self, url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(movies):
                    let collection = movies
                    XCTAssertEqual(collection.id, 550_998)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func testGetImage() throws {
        var imageInter = UIImage()
        imageService.getImage(addresImage: "/qp9jJBPHmF7C9hAilmRny8Ct77L.jpg") { image in
            DispatchQueue.main.async {
                imageInter = image
            }
        }
        XCTAssertNotNil(imageInter)
    }

    func testGetImageAPI() throws {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/qp9jJBPHmF7C9hAilmRny8Ct77L.jpg")
        var imageInter = UIImage()
        guard let url = url else { return }
        imageAPIService.getImage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    imageInter = image
                case let .failure(error):
                    print(error)
                }
            }
        }
        XCTAssertNotNil(imageInter)
    }
}
