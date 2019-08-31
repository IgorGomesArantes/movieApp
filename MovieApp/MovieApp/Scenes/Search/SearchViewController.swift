//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func reload(_ result: ServiceStatus)
}

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private let searchView = SearchView()
    private var viewModel: SearchViewModel!
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        searchView.reload(.blank)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchView.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchView.searchBar.resignFirstResponder()
    }
    
    // MARK: - Initialization methods
    static func instanciate(viewModel: SearchViewModel) -> SearchViewController {
        let viewController = SearchViewController()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Reload methods
    private func onReload(_ result: ServiceStatus) {
        switch result {
        case .success:
            searchView.reload(.full)
        case .error:
            searchView.reload(.error(string: "Erro ao buscar os filmes!"))
        case .loading:
            searchView.reload(.loading)
        case .empty:
            searchView.reload(.empty(string: "Nenhum filme encontrado!"))
        }
    }
    
    // MARK - Configuration methods
    private func initialConfiguration() {
        viewModelConfiguration()
        configureNavigationItem()
        searchViewConfiguration()
    }
    
    private func viewModelConfiguration() {
        viewModel.onChange = { [weak self] result in
            self?.onReload(result)
        }
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

// MARK: - Search bar delegate methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchView.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.stopSearchTimer()
        viewModel.searchQuery = searchText
        
        if searchText.isEmpty {
            searchView.reload(.blank)
        } else {
            viewModel.startSearchTimer()
        }
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
