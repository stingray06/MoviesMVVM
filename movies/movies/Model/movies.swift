// movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit
/// Модель данных

// MARK: - Welcome

/// Модель  данных
struct Welcome: Decodable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
}

// MARK: - Result

/// Модель  данных
struct Result: Decodable {
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    let id: Int?
}
