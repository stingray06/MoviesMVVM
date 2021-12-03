// RealmData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RealmDataProtocol {
    func saveMovies(category: String, movies: [DescriptionMovie])
    func getMovies(urlMovies: String) -> [DescriptionMovie]
    func getAboutMovie(movieID: Int) -> DescriptionMovie
}

final class RealmData: RealmDataProtocol {
    func saveMovies(category: String, movies: [DescriptionMovie]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            movies.forEach { movie in
                let object = DescriptionMovieRealm()
                guard let id = movie.id,
                      let overview = movie.overview,
                      let posterPath = movie.posterPath,
                      let releaseDate = movie.releaseDate,
                      let title = movie.title,
                      let voteAverage = movie.voteAverage else { return }
                object.id = id
                object.overview = overview
                object.posterPath = posterPath
                object.releaseDate = releaseDate
                object.title = title
                object.voteAverage = voteAverage
                object.category = category
                object.categoryID = String(id) + category
                realm.add(object, update: .all)
            }
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func getMovies(urlMovies: String) -> [DescriptionMovie] {
        var movies: [DescriptionMovie] = []
        do { let realm = try Realm()
            guard let printURL = realm.configuration.fileURL else { return [] }
            print(printURL)
            var moviesRealm = realm.objects(DescriptionMovieRealm.self)
            moviesRealm = moviesRealm.filter("category = '\(urlMovies)'")
            movies = moviesRealm.map { object in
                DescriptionMovie(
                    title: object.title,
                    overview: object.overview,
                    releaseDate: object.releaseDate,
                    posterPath: object.posterPath,
                    voteAverage: object.voteAverage,
                    id: object.id
                )
            }
        } catch {
            print(error)
        }
        return movies
    }

    func getAboutMovie(movieID: Int) -> DescriptionMovie {
        let exampleMovie = DescriptionMovie(
            title: "",
            overview: "",
            releaseDate: "0.0",
            posterPath: "",
            voteAverage: 0.0,
            id: 0
        )
        var aboutMovie: DescriptionMovie?
        var movies: [DescriptionMovie]? // = []
        do { let realm = try Realm()
            var moviesRealm = realm.objects(DescriptionMovieRealm.self)
            moviesRealm = moviesRealm.filter("id = %i", movieID)
            movies = moviesRealm.map { object in
                DescriptionMovie(
                    title: object.title,
                    overview: object.overview,
                    releaseDate: object.releaseDate,
                    posterPath: object.posterPath,
                    voteAverage: object.voteAverage,
                    id: object.id
                )
            }
            aboutMovie = movies?.first
        } catch {
            print(error)
        }
        guard let movie = aboutMovie else {
            return exampleMovie
        }
        return movie
    }
}
