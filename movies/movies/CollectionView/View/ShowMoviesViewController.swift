// ShowMoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер
final class ShowMoviesViewController: UIViewController {
    // MARK: - Public Properties

    var showModelView: ShowModelViewProtocol?

    // MARK: - Initiation

    convenience init(showModelView: ShowModelViewProtocol) {
        self.init()
        self.showModelView = showModelView
    }

    // MARK: - Visual Components

    private let imageCell = UIImage()
    private let imageSingleCell = UIImage()
    private let buttonScrollView = UIScrollView()
    private let latestButton = UIButton()
    private let nowPlayingButton = UIButton()
    private let topRatedButton = UIButton()
    private let upcomingButton = UIButton()
    private let popularButton = UIButton()
    private let viewScrollView = UIView()
    private let viewCollectionView = UIView()
    private let moviesCollectionView = UICollectionView(
        frame: CGRect.zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    // MARK: - LyfeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        systemUnits()
    }

    // MARK: - Private Methods

    private func systemUnits() {
        view.backgroundColor = .systemGray6
        navigationItem.title = "Library"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        showModelView?.reloadData = { self.moviesCollectionView.reloadData() }
    }

    private func createViews() {
        createViewScrollView()
        createViewCollectionView()
        createMoviesCollectionView()
        viewCollectionView.addSubview(moviesCollectionView)
        createButtonScrollView()
        createConstraintScrollView()
        createButtonLatest()
        createNowPlayingButton()
        createTopRatedButton()
        createUpcomingButton()
        createPopularButton()
        choiceButton()
        createConstrantsButtons()
        createConstraintCollectionView()
    }

    private func createMoviesCollectionView() {
        moviesCollectionView.register(
            CellCollectionViewCell.self,
            forCellWithReuseIdentifier: CellCollectionViewCell.identifier
        )
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.backgroundColor = .systemGray6
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createConstraintCollectionView() {
        NSLayoutConstraint.activate([
            moviesCollectionView.leadingAnchor.constraint(equalTo: viewCollectionView.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: viewCollectionView.trailingAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: viewCollectionView.topAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: viewCollectionView.bottomAnchor)
        ])
    }

    private func createConstraintScrollView() {
        buttonScrollView.leadingAnchor.constraint(equalTo: viewScrollView.leadingAnchor).isActive = true
        buttonScrollView.trailingAnchor.constraint(equalTo: viewScrollView.trailingAnchor).isActive = true
        buttonScrollView.topAnchor.constraint(equalTo: viewScrollView.topAnchor).isActive = true
        buttonScrollView.bottomAnchor.constraint(equalTo: viewScrollView.bottomAnchor).isActive = true
    }

    private func choiceButton() {
        latestButton.addTarget(self, action: #selector(changeListMovies(sender:)), for: .touchUpInside)
        upcomingButton.addTarget(self, action: #selector(changeListMovies(sender:)), for: .touchUpInside)
        topRatedButton.addTarget(self, action: #selector(changeListMovies(sender:)), for: .touchUpInside)
        nowPlayingButton.addTarget(self, action: #selector(changeListMovies(sender:)), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(changeListMovies(sender:)), for: .touchUpInside)
    }

    private func createViewScrollView() {
        view.addSubview(viewScrollView)
        viewScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }

    private func createViewCollectionView() {
        view.addSubview(viewCollectionView)
        viewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCollectionView.topAnchor.constraint(equalTo: viewScrollView.bottomAnchor),
            viewCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createButtonScrollView() {
        viewScrollView.addSubview(buttonScrollView)
        buttonScrollView.isScrollEnabled = true
        buttonScrollView.backgroundColor = .systemGray6
        buttonScrollView.showsHorizontalScrollIndicator = false
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func createConstrantsButtons() {
        latestButton.trailingAnchor.constraint(
            equalTo: nowPlayingButton.leadingAnchor,
            constant: -10
        ).isActive = true
        nowPlayingButton.trailingAnchor.constraint(
            equalTo: topRatedButton.leadingAnchor,
            constant: -10
        ).isActive = true
        topRatedButton.trailingAnchor.constraint(
            equalTo: upcomingButton.leadingAnchor,
            constant: -10
        ).isActive = true
        upcomingButton.trailingAnchor.constraint(
            equalTo: popularButton.leadingAnchor,
            constant: -10
        ).isActive = true
        latestButton.leadingAnchor.constraint(
            equalTo: buttonScrollView.leadingAnchor,
            constant: 10
        ).isActive = true
        latestButton.topAnchor.constraint(
            equalTo: buttonScrollView.topAnchor,
            constant: 10
        ).isActive = true
        latestButton.bottomAnchor.constraint(
            equalTo: buttonScrollView.bottomAnchor,
            constant: 10
        ).isActive = true
        nowPlayingButton.topAnchor.constraint(
            equalTo: buttonScrollView.topAnchor,
            constant: 10
        ).isActive = true
        nowPlayingButton.bottomAnchor.constraint(
            equalTo: buttonScrollView.bottomAnchor,
            constant: 10
        ).isActive = true
        topRatedButton.topAnchor.constraint(
            equalTo: buttonScrollView.topAnchor,
            constant: 10
        ).isActive = true
        topRatedButton.bottomAnchor.constraint(
            equalTo: buttonScrollView.bottomAnchor,
            constant: 10
        ).isActive = true
        upcomingButton.topAnchor.constraint(
            equalTo: buttonScrollView.topAnchor,
            constant: 10
        ).isActive = true
        upcomingButton.bottomAnchor.constraint(
            equalTo: buttonScrollView.bottomAnchor,
            constant: 10
        ).isActive = true
        popularButton.trailingAnchor.constraint(
            equalTo: buttonScrollView.trailingAnchor,
            constant: -10
        ).isActive = true
        popularButton.topAnchor.constraint(
            equalTo: buttonScrollView.topAnchor,
            constant: 10
        ).isActive = true
        popularButton.bottomAnchor.constraint(
            equalTo: buttonScrollView.bottomAnchor,
            constant: 10
        ).isActive = true
        latestButton.widthAnchor.constraint(equalTo: nowPlayingButton.widthAnchor).isActive = true
        nowPlayingButton.widthAnchor.constraint(equalTo: topRatedButton.widthAnchor).isActive = true
        topRatedButton.widthAnchor.constraint(equalTo: upcomingButton.widthAnchor).isActive = true
        upcomingButton.widthAnchor.constraint(equalTo: popularButton.widthAnchor).isActive = true
        latestButton.centerYAnchor.constraint(equalTo: buttonScrollView.centerYAnchor).isActive = true
    }

    private func createButtonLatest() {
        latestButton.setTitle("Latest", for: .normal)
        latestButton.backgroundColor = .cyan
        latestButton.layer.cornerRadius = 10
        latestButton.setTitleColor(.gray, for: .normal)
        latestButton.setTitleColor(.black, for: .highlighted)
        latestButton.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.addSubview(latestButton)
    }

    private func createNowPlayingButton() {
        nowPlayingButton.setTitle("  NowPlaying  ", for: .normal)
        nowPlayingButton.backgroundColor = .cyan
        nowPlayingButton.layer.cornerRadius = 10
        nowPlayingButton.setTitleColor(.gray, for: .normal)
        nowPlayingButton.setTitleColor(.black, for: .highlighted)
        nowPlayingButton.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.addSubview(nowPlayingButton)
    }

    private func createTopRatedButton() {
        topRatedButton.setTitle("TopRated", for: .normal)
        topRatedButton.backgroundColor = .cyan
        topRatedButton.layer.cornerRadius = 10
        topRatedButton.setTitleColor(.gray, for: .normal)
        topRatedButton.setTitleColor(.black, for: .highlighted)
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.addSubview(topRatedButton)
    }

    private func createUpcomingButton() {
        upcomingButton.setTitle("Upcoming", for: .normal)
        upcomingButton.backgroundColor = .cyan
        upcomingButton.layer.cornerRadius = 10
        upcomingButton.setTitleColor(.gray, for: .normal)
        upcomingButton.setTitleColor(.black, for: .highlighted)
        upcomingButton.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.addSubview(upcomingButton)
    }

    private func createPopularButton() {
        popularButton.setTitle("Popular", for: .normal)
        popularButton.backgroundColor = .cyan
        popularButton.layer.cornerRadius = 10
        popularButton.setTitleColor(.gray, for: .normal)
        popularButton.setTitleColor(.black, for: .highlighted)
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.addSubview(popularButton)
    }

    @objc private func changeListMovies(sender: UIButton) {
        switch sender {
        case latestButton:
            showModelView?.fetchMovie(urlMovies: .latestURL)
        case nowPlayingButton:
            showModelView?.fetchMovie(urlMovies: .nowPlayingURL)
        case topRatedButton:
            showModelView?.fetchMovie(urlMovies: .topRatedURL)
        case upcomingButton:
            showModelView?.fetchMovie(urlMovies: .upComingURL)
        case popularButton:
            showModelView?.fetchMovie(urlMovies: .popularURL)
        default:
            break
        }
    }
}

// MARK: - Extension UICollectionViewDataSource

extension ShowMoviesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let cells = showModelView?.json?.results.count else { return 0 }
        return cells
    }
}

// MARK: - Extension UICollectionViewDelegate

extension ShowMoviesViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellCollectionViewCell.identifier,
            for: indexPath
        ) as?
            CellCollectionViewCell else { return UICollectionViewCell() }
        guard let movie = showModelView?.json?.results[indexPath.row] else { return UICollectionViewCell() }
        showModelView?.fetchImageCollectionView(movie: movie, completion: { result in
            DispatchQueue.main.async {
                itemCell.imageView.image = result
            }
        })
        return itemCell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension ShowMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (view.frame.size.width / 2.1) - 3, height: (view.frame.size.width / 1.5) - 3)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondVC = AboutMovieViewController()
        guard let numberID = showModelView?.json?.results[indexPath.row].id else { return }
        secondVC.movieID = numberID
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
