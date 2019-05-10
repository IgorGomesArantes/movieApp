//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: class {
    func configureMyList()
    func configureRecomendations()
    func configurePopular()
}

class HomeViewController: UIViewController {
    
    // MARK: - View properties
    private let homeView = HomeView()
    //private let homeView = PopularView()
    
    // MARK: - Properties
    private var viewModel: HomeViewModel!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        start()
    }

    // MARK: - Initialization methods
    static func instantiate(viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController = HomeViewController()
        
        homeViewController.viewModel = viewModel
        
        return homeViewController
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        viewModel.onResponse = onResponse
        tableViewHierarchyConfiguration()
    }
    
    private func start() {
        viewModel.reload()
    }
    
    // MARK: - Private methods
    private func onResponse(result: HomeViewModel.options) {
        switch result {
        case .popular(let result):
            popularHandle(result: result)
        default:
            break
        }
    }
    
    private func popularHandle(result: ServiceStatus<MoviePage>) {
        switch result {
        case .success(let result):
            debugPrint(result)
        default:
            break
        }
    }
    
    private func tableViewHierarchyConfiguration() {
        view.addSubview(homeView)
        homeView.frame = view.bounds
        homeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
