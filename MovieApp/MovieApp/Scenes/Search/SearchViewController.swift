//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func reload(_ result: ServiceStatus<[Movie]>)
}

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private let searchView = SearchView()
    private var viewModel: SearchViewModel!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        viewModel.reload(query: "")
    }
    
    // MARK: - Initialization methods
    static func instanciate(viewModel: SearchViewModel) -> SearchViewController {
        let viewController = SearchViewController()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK - Configuration methods
    private func initialConfiguration() {
        configureNavigationItem()
        searchViewConfiguration()
    }
    
    private func searchViewConfiguration() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        searchView.searchBar.delegate = self
        searchView.resultCollectionView.delegate = self
        searchView.resultCollectionView.dataSource = self
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Busca"
    }
}

// MARK: - Search view controller delegate methods
extension SearchViewController: SearchViewControllerDelegate {
    func reload(_ result: ServiceStatus<[Movie]>) {
        switch result {
        case .success:
            searchView.resultCollectionView.reloadData()
        case .error:
            break
        case .loading:
            break
        case .empty:
            break
        }
    }
}

// MARK: - Search bar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancel()
    }
}

// MARK: - Collection view delegate and datasource methods
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.resultCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchView.resultCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.reuseIdentifier, for: indexPath) as! ResultCollectionViewCell
        
        viewModel.configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
}
