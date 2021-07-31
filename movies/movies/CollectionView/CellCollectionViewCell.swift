// CellCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка CollectionView
final class CellCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCell"

    // MARK: - Private Properties

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    // MARK: - LyfeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    // MARK: - Public Method

    func fetchImageCollectionView(movie: Result) {
        guard let addresImage = movie.posterPath else { return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + addresImage) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in guard let self = self else { return }
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
