//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func reload(_ result: ServiceStatus<Movie>)
}

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let detailView = DetailView()
    private var viewModel: DetailViewModel!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        viewModel.reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent || isBeingDismissed {
            viewModel.back()
        }
    }
    
    // MARK: - Initialization methods
    static func instanciate(viewModel: DetailViewModel) -> DetailViewController {
        let viewController = DetailViewController()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK - Configuration methods
    private func initialConfiguration() {
        configureNavigationItem()
        detailViewConfiguration()
    }
    
    private func detailViewConfiguration() {
        view.addSubview(detailView)
        detailView.frame = view.bounds
        detailView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Detalhes"
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    func reload(_ result: ServiceStatus<Movie>) {
        switch result {
        case .success:
            viewModel.configure(detailView)
        case .error:
            break
        case .loading:
            break
        case .empty:
            break
        }
    }
}


