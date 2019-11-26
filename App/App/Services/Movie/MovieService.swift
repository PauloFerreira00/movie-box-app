//
//  MovieService.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

class MovieService: BaseService<MovieApi> {

    static let shared = MovieService()

    func fetchPopularMovies(pageNumber: Int, completion: @escaping RequestCompletionHandler<MovieListResponse>) {
        fetch(.popularMovies(pageNumber: pageNumber, language: Language.pt_BR), dataType: MovieListResponse.self, completion: completion)
    }

    func fetchCredits(id: Int, completion: @escaping RequestCompletionHandler<MovieCredits>) {
        fetch(.credits(id: id, language: Language.pt_BR), dataType: MovieCredits.self, completion: completion)
    }
}
