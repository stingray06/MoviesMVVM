// AboutMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка TableView
final class AboutMovieViewController: UIViewController {
    
    //MARK: - Visual Components
    
    var movieTable = UITableView()
    
    // MARK: - Public Properties

    var idMovie = Int()

    // MARK: - Private Properties

    
    private var aboutMovie: Result?
    private let suffixURL = String()

    // MARK: - LyfeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createMovieTable()
        systemUnits()
    }

    // MARK: - Private Methods

    private func systemUnits() {
        movieTable.backgroundColor = .systemGray6
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemGray6
    }

    private func createMovieTable() {
        movieTable = UITableView(frame: view.bounds, style: .plain)
        movieTable.separatorStyle = .none
        movieTable.register(AboutMovieTableViewCell.self, forCellReuseIdentifier: AboutMovieTableViewCell.identifier)
        view.addSubview(movieTable)
        movieTable.delegate = self
        movieTable.dataSource = self
    }

    func fetchDataAboutMovie(cell: AboutMovieTableViewCell, indexPath: IndexPath) {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/" + "\(idMovie)" +
                    "?api_key=90f917324ecb224bd306de1b97b17591&language=ru-RU"
            )
        else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.aboutMovie = try decoder.decode(Result.self, from: data)
                DispatchQueue.main.async {
                    cell.aboutMoviesLabel.text = self.aboutMovie?.overview
                    guard let release = self.aboutMovie?.releaseDate else { return }
                    cell.releaseDateLabel.text = "Даты выхода: \(release))"
                    guard let mark = self.aboutMovie?.voteAverage else { return }
                    cell.voteLabel.text = "Оценка \(mark)"
                    cell.titleMoviesLabel.text = self.aboutMovie?.title
                    self.movieTable.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
        guard let addresImage = aboutMovie?.posterPath else { return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.posterMovieImageView.image = image
                    self.movieTable.reloadData()
                }
            }
        }.resume()
    }
}

extension AboutMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellTable = tableView.dequeueReusableCell(
            withIdentifier: AboutMovieTableViewCell.identifier,
            for: indexPath
        ) as?
            AboutMovieTableViewCell else { return UITableViewCell() }
        fetchDataAboutMovie(cell: cellTable, indexPath: indexPath)
        return cellTable
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        700
    }
}
