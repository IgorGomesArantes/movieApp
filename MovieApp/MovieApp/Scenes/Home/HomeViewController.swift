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
    func popular(_ result: ServiceStatus<MoviePage>)
}

class HomeViewController: UIViewController {
    
    // MARK: - View properties
    private let homeView = HomeView()
    
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
    
    private func start() {
        viewModel.reload()
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        homeView.popularCollectionView.delegate = self
        homeView.popularCollectionView.dataSource = self
        
        homeViewConfiguration()
        navigationItemConfiguration()
    }

    private func homeViewConfiguration() {
        view.addSubview(homeView)
        homeView.frame = view.bounds
        homeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func navigationItemConfiguration() {
        navigationItem.title = "Home"
        
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonAction))
        navigationItem.rightBarButtonItem = button
    }
    
    // MARK: - Action methods
    @objc private func searchButtonAction() {
        viewModel.search()
    }
}

// MARK: - Home view controller delegate methods
extension HomeViewController: HomeViewControllerDelegate {
    func popular(_ result: ServiceStatus<MoviePage>) {
        switch result {
        case .success(let result):
            homeView.popularCollectionView.reloadData()
            debugPrint(result)
        default:
            break
        }
    }
}

// MARK: - Collection view delegate and data source methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.popularCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeView.popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularCollectionViewCell
        
        let cellViewModel = viewModel.popularViewModel(index: indexPath.row)
        
        cell.setup(cellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.popularDetail(indexPath.row)
    }
}
