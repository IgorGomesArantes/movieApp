//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Vieww properties
    private let detailView = DetailView()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Properties
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        detailView.contentScrollView.setContentOffset(.zero, animated: true)
//    }
    
    // MARK: - Initialization methods
    static func instanciate(viewModel: DetailViewModel) -> DetailViewController {
        let viewController = DetailViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    deinit {
        debugPrint("Detail view controller deinit")
    }
    
    // MARK: - Reload methods
    private func reloadDetails(_ status: ServiceStatus) {
        switch status {
        case .success:
            activityIndicator.stopAnimating()
            detailView.isHidden = false
            viewModel.configure(detailView)
            
        case .loading:
            detailView.isHidden = true
            activityIndicator.startAnimating()

        case .empty, .error:
            break
        }
    }
    
    private func reloadRecomendations(_ status: ServiceStatus) {
        switch status {
        case .success:
            detailView.recomendationCollection.reloadData()
            detailView.updateConstraints()
            
        case .error, .loading, .empty:
            break
        }
    }
    
    // MARK - Configuration methods
    private func initialConfiguration() {
        viewModelConfiguration()
        navigationConfiguration()
        viewConfiguration()
        detailViewConfiguration()
        activityIndicatorConfiguration()
        recomendationCollectionConfiguration()
    }
    
    private func viewModelConfiguration() {
        viewModel.onReloadDetails = { [weak self] status in
            self?.reloadDetails(status)
        }
        
        viewModel.onReloadRecomendations = { [weak self] status in
            self?.reloadRecomendations(status)
        }
    }
    
    private func navigationConfiguration() {
        navigationItem.title = "Detalhes"
    }
    
    private func viewConfiguration() {
        view.backgroundColor = .white
    }
    
    private func activityIndicatorConfiguration() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
    }
    
    private func detailViewConfiguration() {
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func recomendationCollectionConfiguration() {
        detailView.recomendationCollection.delegate = self
        detailView.recomendationCollection.dataSource = self
        
        detailView.recomendationCollection.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.reuseIdentifier)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRecomendations
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
