//
//  PopularTableViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "popularTableViewCell"
    var collectionView: UICollectionView!
    var viewModel: PopularCollectionViewModel!
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Public methods
    func setup(movies: [Movie]) {
        viewModel = PopularCollectionViewModel(movies: movies)
        collectionConfiguration()
        hierarchyConfiguration()
        
        collectionView.reloadData()
    }
    
    // MARK: - Configuration methods
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
    }
    
    private func buildFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = UIScreen.main.bounds.width / 2.0
        let cellHeight = cellWidth * 1.5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return layout
    }
}

// MARK: - Collection delegate and datasource methods
extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularCollectionViewCell
        
        viewModel.popularViewModel(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectAt(index: indexPath.row)
    }
}

