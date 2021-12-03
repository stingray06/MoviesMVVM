// CellCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CellCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCell"

    // MARK: - Private Properties

    private let imageService = ImageService()
    var imageView: UIImageView = {
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

    func fetchImageCollectionView(movie: DescriptionMovie, completion: @escaping (UIImage) -> ()) {
        guard let addresImage = movie.posterPath else { return }
        imageService.getImage(addresImage: addresImage) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
