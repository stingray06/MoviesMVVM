// movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
/// Модель данных

// MARK: - Welcome

/// Модель  данных
struct Movies: Decodable {
    let results: [DescriptionMovie]
}

// MARK: - Result

/// Модель  данных
struct DescriptionMovie: Decodable {
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    let id: Int?
}

final class DescriptionMovieRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var overview = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var voteAverage = Double()
    @objc dynamic var id = Int()
    @objc dynamic var category = ""
    @objc dynamic var categoryID = ""

    override static func primaryKey() -> String? {
        "categoryID"
    }
}
