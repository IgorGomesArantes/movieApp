//
//  MyListTableViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    static let reuseIdentifier = "myListTableViewCell"
    
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    private var collectionView: UICollectionView!
    private var viewModel = MyListViewModel()
    
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MyListCell.self, forCellWithReuseIdentifier: MyListCell.reuseIdentifier)
    }
    
    // MARK: - Build methods
    private func buildFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = UIScreen.main.bounds.width / 5.0
        let cellHeight = cellWidth * 1.5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return layout
    }
}

// MARK: - Collection delegate and datasource methods
extension MyListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCell.reuseIdentifier, for: indexPath) as! MyListCell
        
        viewModel.configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode = viewModel.getMovieCode(by: indexPath.row)
        delegate?.didSelectMovie(code: movieCode)
    }
}
