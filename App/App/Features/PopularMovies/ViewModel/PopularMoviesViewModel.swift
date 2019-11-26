//
//  PopularListViewModel.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import UIKit

enum PopularMoviesState {
    case loading
    case empty
    case loaded
    case error
}

protocol PopularMoviesViewModelContract {
    func fetch(completion: @escaping (Result<Void, Error>) -> Void)
    func cellFor(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    var stateChange: (() -> Void)? { get set }
    var currentState: PopularMoviesState { get }
    var popularMovies: [Movie] { get }
}

class PopularMoviesViewModel: PopularMoviesViewModelContract {

    var stateChange: (() -> Void)?

    var currentState: PopularMoviesState = .loading {
        didSet {
            stateChange?()
        }
    }

    let service: MovieService
    let pageNumber: Int
    var popularMovies: [Movie] = []

    init(pageNumber: Int, service: MovieService = MovieService.shared) {
        self.service = service
        self.pageNumber = pageNumber
    }

    func fetch(completion: @escaping (Result<Void, Error>) -> Void) {
        currentState = .loading
        service.fetchPopularMovies(pageNumber: pageNumber) { (result) in
            switch result {
            case .success(let response):
                self.currentState = .loaded
                self.popularMovies = response.results
                return completion(.success(()))
            case .failure(let error):
                self.currentState = .error
                return completion(.failure(error))
            default: break
            }
        }
    }

    func cellFor(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let movie = popularMovies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(of: MovieCell.self, for: indexPath) { cell in
            let viewModel = MovieCellViewModel(movie: movie)
            cell.setup(with: viewModel)
        }
        return cell
    }

}
