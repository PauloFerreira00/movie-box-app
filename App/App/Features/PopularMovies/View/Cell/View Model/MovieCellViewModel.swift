//
//  MovieCellViewModel.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 25/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

protocol MovieCellViewModelContract {
    func getMovie() -> Movie
    func getRatingValue() -> Double
}

class MovieCellViewModel: MovieCellViewModelContract {

    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    func getMovie() -> Movie {
        return Movie(id: movie.id, title: movie.title,
                     releaseDate: getFormattedReleaseDate(),
                     posterPath: getCoverUrlString(), voteAverage: movie.voteAverage)
    }

    func getCoverUrlString() -> String {
        let posterPath = movie.posterPath ?? ""
        let urlString = "\(Environment.imageBaseUrl)\(posterPath)"
        return urlString
    }

    func getRatingValue() -> Double {
        let voteAverage = movie.voteAverage ?? 0
        return voteAverage / 2
    }

    private func getFormattedReleaseDate() -> String {
        let date = movie.releaseDate ?? ""
        let dateFormatter = DateFormatter()
        return dateFormatter.formatWith(dateString: date, patternInput: "yyyy-MM-dd", patternOutput: "dd/MM/yyyy")
    }
}
