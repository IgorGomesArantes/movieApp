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
    func reloadRecomendations(_ result: ServiceStatus<[Movie]>)
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
        viewModel.reloadRecomendations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent || isBeingDismissed {
            viewModel.back()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailView.contentScrollView.setContentOffset(.zero, animated: false)
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
        recomendationCollectionConfiguration()
        myListButtonConfiguration()
    }
    
    private func detailViewConfiguration() {
        view.addSubview(detailView)
        detailView.frame = view.bounds
        detailView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func recomendationCollectionConfiguration() {
        detailView.recomendationCollection.delegate = self
        detailView.recomendationCollection.dataSource = self
        
        detailView.recomendationCollection.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.reuseIdentifier)
    }
    
    private func myListButtonConfiguration() {
        detailView.myListButton.addTarget(self, action: #selector(saveOrRemove), for: .touchDown)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Detalhes"
    }
    
    // MARK: - Action methods
    @objc func saveOrRemove() {
        viewModel.saveOrRemove(detailView)
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
    
    func reloadRecomendations(_ result: ServiceStatus<[Movie]>) {
        switch result {
        case .success:
            detailView.recomendationCollection.reloadData()
            detailView.updateConstraints()
        case .error:
            break
        case .loading:
            break
        case .empty:
            break
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recomendations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = detailView.recomendationCollection.dequeueReusableCell(withReuseIdentifier: RecomendationCell.reuseIdentifier, for: indexPath) as! RecomendationCell
        
        viewModel.configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detail(indexPath.row)
    }
}
