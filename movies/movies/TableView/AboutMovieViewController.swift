// AboutMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка TableView
final class AboutMovieViewController: UIViewController {
    // MARK: - Visual Components

    var movieTable = UITableView()

    // MARK: - Public Properties

    var aboutViewModel: AboutViewModelProtocol?

    // MARK: - Private Properties

    private var aboutMovie: DescriptionMovie?
    private let suffixURL = String()

    // MARK: - Initiation

    convenience init(aboutModelView: AboutViewModelProtocol) {
        self.init()
        aboutViewModel = aboutModelView
    }

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
        aboutViewModel?.reloadData = { self.movieTable.reloadData() }
    }

    private func createMovieTable() {
        movieTable = UITableView(frame: view.bounds, style: .plain)
        movieTable.separatorStyle = .none
        movieTable.register(AboutMovieTableViewCell.self, forCellReuseIdentifier: AboutMovieTableViewCell.identifier)
        view.addSubview(movieTable)
        movieTable.delegate = self
        movieTable.dataSource = self
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
        guard let movieID = aboutViewModel?.movieID else { return cellTable }
        aboutViewModel?.fetchDataAboutMovie(cell: cellTable, indexPath: indexPath, movieID: movieID)
        aboutViewModel?.fetchPosterMovie(cell: cellTable, indexPath: indexPath, movieID: movieID) { image in
            DispatchQueue.main.async {
                cellTable.posterMovieImageView.image = image
            }
        }
        return cellTable
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        700
    }
}
