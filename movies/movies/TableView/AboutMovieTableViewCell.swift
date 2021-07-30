// AboutMovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер
final class AboutMovieTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    static let identifier = "CellMovie"

    // MARK: - Private Properties

    private let posterMovieImageView = UIImageView()
    private let aboutMoviesLabel = UILabel()
    private let titleMoviesLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let voteLabel = UILabel()
    private let idMovie = Int()

    // MARK: - LyfeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        createView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Properties

    func fetchDataMovie(aboutMovie: Result) {
        guard let addresOverview = aboutMovie.overview else { return }
        aboutMoviesLabel.text = addresOverview
        guard let release = aboutMovie.releaseDate else { return }
        releaseDateLabel.text = "Даты выхода: \(release)"
        guard let mark = aboutMovie.voteAverage else { return }
        voteLabel.text = "Оценка \(mark)"
        titleMoviesLabel.text = aboutMovie.title
        guard let addresImage = aboutMovie.posterPath else { return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterMovieImageView.image = image
                }
            }
        }.resume()
    }

    // MARK: - Private Properties

    func createView() {
        createOverviewMovie()
        createPosterImage()
        createReleaseLabel()
        createTitleLabel()
        createVoteLabel()
        createConstraintPoster()
    }

    func createConstraintPoster() {
        NSLayoutConstraint.activate([
            titleMoviesLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleMoviesLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleMoviesLabel.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 25),
            titleMoviesLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 25),
            titleMoviesLabel.widthAnchor.constraint(equalToConstant: 100),
            posterMovieImageView.heightAnchor.constraint(equalToConstant: 400),
            posterMovieImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            posterMovieImageView.topAnchor.constraint(equalTo: titleMoviesLabel.bottomAnchor, constant: 5),
            posterMovieImageView.leadingAnchor.constraint(
                greaterThanOrEqualTo: leadingAnchor,
                constant: UIScreen.main.bounds.width / 7
            ),
            posterMovieImageView.trailingAnchor.constraint(
                greaterThanOrEqualTo: trailingAnchor, constant: UIScreen.main.bounds.width / 7
            ),
            aboutMoviesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            aboutMoviesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            aboutMoviesLabel.topAnchor.constraint(equalTo: posterMovieImageView.bottomAnchor, constant: 30),
            aboutMoviesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            releaseDateLabel.topAnchor.constraint(equalTo: posterMovieImageView.bottomAnchor, constant: 1),
            releaseDateLabel.bottomAnchor.constraint(equalTo: aboutMoviesLabel.topAnchor, constant: 1),
            voteLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: releaseDateLabel.trailingAnchor,
                multiplier: 1
            ),
            voteLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            voteLabel.centerYAnchor.constraint(equalTo: releaseDateLabel.centerYAnchor)
        ])
    }

    private func createPosterImage() {
        posterMovieImageView.contentMode = .scaleAspectFit
        posterMovieImageView.clipsToBounds = true
        addSubview(posterMovieImageView)
        posterMovieImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createOverviewMovie() {
        addSubview(aboutMoviesLabel)
        aboutMoviesLabel.textAlignment = .natural
        aboutMoviesLabel.lineBreakMode = .byClipping
        aboutMoviesLabel.numberOfLines = 30
        aboutMoviesLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createReleaseLabel() {
        addSubview(releaseDateLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createTitleLabel() {
        titleMoviesLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMoviesLabel.textAlignment = .center
        titleMoviesLabel.font = UIFont(name: "helvetica", size: 28)
        titleMoviesLabel.numberOfLines = 2
        titleMoviesLabel.lineBreakMode = .byWordWrapping
        addSubview(titleMoviesLabel)
    }

    private func createVoteLabel() {
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(voteLabel)
    }
}
