//
//  Recomendations.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    static let reuseIdentifier = "topRatedTableViewCell"
    
    private static let cellWidth = ceil((UIScreen.main.bounds.width / 2.0) - 30)
    private static let cellHeight = ceil(cellWidth * 0.5)
    
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: buildFlowLayout())
    private var viewModel = TopRatedViewModel()
    
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
        let height = (TopRatedTableViewCell.cellHeight + CGFloat(15)) * ceil(CGFloat(viewModel.count) / 2.0) + CGFloat(10)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        collectionConfiguration()
    }
    
    private func collectionConfiguration() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.reuseIdentifier)
    }
    
    // MARK: - Build methods
    private static func buildFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: TopRatedTableViewCell.cellWidth, height: TopRatedTableViewCell.cellHeight)
        
        return layout
    }
}

// MARK: - Collection delegate and datasource methods
extension TopRatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
