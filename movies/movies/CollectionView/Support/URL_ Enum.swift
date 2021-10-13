// URL_ Enum.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Enum для ссылок на категории фильмов
enum URLType: String {
    case ulMovies =
        "https://api.themoviedb.org/3/movie/popular?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=3"
    case latestURL =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=3"
    case nowPlayingURL =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=1"
    case upComingURL =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=1"
    case popularURL =
        "https://api.themoviedb.org/3/movie/popular?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=1"
    case topRatedURL =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU&page=1"
}
