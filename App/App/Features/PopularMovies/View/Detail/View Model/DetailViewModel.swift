//
//  DetailViewModel.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 26/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//


enum DetailState {
    case loading
    case empty
    case loaded
    case error
}

protocol DetailViewModelContract {
    func fetch(completion: @escaping (Result<Void, Error>) -> Void)
    var stateChange: (() -> Void)? { get set }
    var currentState: PopularMoviesState { get }
    var popularMovies: [Movie] { get }
}

protocol DetailViewModel: DetailViewModelContract {
    
}
