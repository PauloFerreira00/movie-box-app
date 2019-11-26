//
//  MovieCell.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 25/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var customBackgroundView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    var viewModel: MovieCellViewModelContract?

    func setup(with viewModel: MovieCellViewModelContract) {
        self.viewModel = viewModel
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        setupUI()
        setup()
    }

    func setup() {
        guard let movie = viewModel?.getMovie() else { return }
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        evaluationLabel.text = movie.voteAverage?.description
        ratingView.rating = viewModel?.getRatingValue() ?? 0
        setupImage(with: movie.posterPath)
    }

    func setupUI() {
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        customBackgroundView.layer.cornerRadius = 4
    }

    func setupImage(with posterPath: String?) {
        guard let posterPath = posterPath else { return }
        guard let url = URL(string: posterPath) else { return }
        coverImageView.kf.setImage(with: url)
    }

}
