// AboutMovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер
final class AboutMovieTableViewCell: UITableViewCell {
    // MARK: - Visual Components

    var posterMovieImageView = UIImageView()
    var aboutMoviesLabel = UILabel()
    var titleMoviesLabel = UILabel()
    var releaseDateLabel = UILabel()
    var voteLabel = UILabel()

    // MARK: - Public Properties

    static let identifier = "CellMovie"

    // MARK: - Private Properties

    private let idMovie = Int()

    // MARK: - LyfeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        createView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func createView() {
        createOverviewMovie()
        createPosterImage()
        createReleaseLabel()
        createTitleLabel()
        createVoteLabel()
        createConstraintPoster()
    }

    private func createConstraintPoster() {
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
        posterMovieImageView.contentMode = .scaleToFill
        posterMovieImageView.clipsToBounds = true
        posterMovieImageView.backgroundColor = .gray
        posterMovieImageView.layer.cornerRadius = 10
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
