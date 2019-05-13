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
    func myList()
    func popular(_ result: ServiceStatus<MoviePage>)
    func recomendations()
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
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        viewModel.controllerDelegate = self
        homeView.popularCollectionView.delegate = self
        homeView.popularCollectionView.dataSource = self
        
        homeViewConfiguration()
    }
    
    private func start() {
        viewModel.reload()
    }
    
    // MARK: - Configuration methods
    private func homeViewConfiguration() {
        view.addSubview(homeView)
        homeView.frame = view.bounds
        homeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func myList() {
        
    }
    
    func popular(_ result: ServiceStatus<MoviePage>) {
        switch result {
        case .success(let result):
            homeView.popularCollectionView.reloadData()
            debugPrint(result)
        default:
            break
        }
    }
    
    func recomendations() {
        
    }
}

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
