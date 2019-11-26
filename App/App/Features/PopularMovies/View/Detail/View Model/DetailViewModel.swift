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
    var currentState: DetailState { get }
    var detail: MovieDetail? { get }
}

class DetailViewModel: DetailViewModelContract {

    var stateChange: (() -> Void)?
    var currentState: DetailState = .loading {
        didSet {
            stateChange?()
        }
    }

    let movie: Movie
    var credits: MovieCredits?
    var detail: MovieDetail?
    let service: MovieService

    init(movie: Movie, service: MovieService = MovieService.shared) {
        self.movie = movie
        self.service = service
    }

    func fetch(completion: @escaping (Result<Void, Error>) -> Void) {
        currentState = .loading
        service.fetchCredits(id: movie.id) { result in
            switch result {
            case .success(let credits):
                self.currentState = .loaded
                self.credits = credits
                self.setupDetail(credits: credits)
                return completion(.success(()))
            case .failure(let error):
                self.currentState = .error
                return completion(.failure(error))
            default: break
            }
        }
    }

    func setupDetail(credits: MovieCredits) {
        let author = getAuthor()
        let director = getDirector()
        self.detail = MovieDetail(movie: self.movie, author: author, director: director)
    }

    func getAuthor() -> String {
        var name: String = "Não informado"
        credits?.crew.forEach { crew in
            if crew.job == "Writer" {
                name = crew.name
            }
        }
        return name
    }

    func getDirector() -> String {
        var name: String = "Não informado"
        credits?.crew.forEach { crew in
            if crew.job == "Director" {
                name = crew.name
            }
        }
        return name
    }

}
