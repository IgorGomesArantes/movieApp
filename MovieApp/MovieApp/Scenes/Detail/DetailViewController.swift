//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate {
    func reload(_ result: ServiceStatus<Movie>)
}

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let detailView = DetailView()
    var viewModel: DetailViewModel!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
    }
    
    // MARK: - Initialization methods
    static func instanciate(viewModel: DetailViewModel) -> DetailViewController {
        let viewController = DetailViewController()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func start() {
        initialConfiguration()
    }
    
    // MARK - Configuration methods
    func initialConfiguration() {
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        navigationItem.title = "Detalhes"
    }
}


