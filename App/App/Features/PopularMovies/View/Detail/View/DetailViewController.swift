//
//  DetailViewController.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 26/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class DetailViewController: UIViewController {

    var viewModel: DetailViewModelContract?

    static func instantiate(with viewModel: DetailViewModelContract) -> DetailViewController {
        let viewController = DetailViewController(nib: R.nib.detailViewController)
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        print(viewModel?.detail)
    }

    func fetch() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.fetch(completion: { result in
                switch result {
                case .success:
                    print()
                case .failure(let error):
                    let banner = FloatingNotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
                    banner.show(cornerRadius: 10)
                }
            })
        }
    }

}
