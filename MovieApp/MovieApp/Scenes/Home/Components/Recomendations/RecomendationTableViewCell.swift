//
//  Recomendations.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class RecomendationTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    static let reuseIdentifier = "recomendationTableViewCell"
    
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    private var collectionView: UICollectionView!
    private var viewModel = RecomendationViewModel()
    
    // MARK: - Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(movies: [Movie]) {
        viewModel.setup(movies: movies)
        collectionView.reloadData()
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        collectionConfiguration()
        hierarchyConfiguration()
    }
    
    private func hierarchyConfiguration() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func collectionConfiguration() {
        let layout = buildFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.reuseIdentifier)
    }
    
    // MARK: - Build methods
    private func buildFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = (UIScreen.main.bounds.width / 2.0) - 30
        let cellHeight = cellWidth * 0.5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return layout
    }
}

// MARK: - Collection delegate and datasource methods
extension RecomendationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationCell.reuseIdentifier, for: indexPath) as! RecomendationCell
        
        viewModel.configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode = viewModel.getMovieCode(by: indexPath.row)
        delegate?.didSelectMovie(code: movieCode)
    }
}
