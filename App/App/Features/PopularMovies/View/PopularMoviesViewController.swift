//
//  PopularMovieListViewController.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 24/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class PopularMoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl = UIRefreshControl()

    var viewModel: PopularMoviesViewModelContract?

    static func instantiate(with viewModel: PopularMoviesViewModelContract) -> PopularMoviesViewController {
        let viewController = PopularMoviesViewController(nib: R.nib.popularMoviesViewController)
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func fetch() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.fetch(completion: { result in
                switch result {
                case .success:
                    self?.stopRefresh()
                    self?.reload()
                case .failure(let error):
                    self?.stopRefresh()
                    let banner = FloatingNotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                    banner.show(cornerRadius: 10)
                }
            })
        }
    }

    func bind() {
        guard var viewModel = viewModel else { return }
        viewModel.stateChange = { [weak self] in
            switch viewModel.currentState {
            case .loaded:
                self?.reload()
            case .error:
                self?.stopRefresh()
            case .loading:
                self?.refreshControl.beginRefreshing()
            default:
                break
            }
        }
    }

    func setupUI() {
        collectionView.register(MovieCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
    }

    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func stopRefresh() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }

    @objc func refresh() {
        fetch()
    }

}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: self.view.frame.width - 20, height: 170)
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.popularMovies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel?.cellFor(collectionView: collectionView, at: indexPath) ?? UICollectionViewCell()
    }

}
