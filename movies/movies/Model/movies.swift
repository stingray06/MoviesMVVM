// movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
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
