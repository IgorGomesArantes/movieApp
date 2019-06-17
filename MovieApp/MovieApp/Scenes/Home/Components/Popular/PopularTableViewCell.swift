//
//  PopularTableViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 16/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let reuseIdentifier = "popularTableViewCell"
    
    private static let cellWidth = ceil(UIScreen.main.bounds.width / 2.0)
    private static let cellHeight = ceil(cellWidth * 1.5)
    
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: buildFlowLayout())
    private var viewModel = PopularViewModel()

    // MARK: - Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = .flexibleHeight
    }
    
    // MARK: - Public methods
    func setup(movies: [Movie]) {
        viewModel.setup(movies: movies)
        collectionView.reloadData()
        updateConstraints()
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        collectionConfiguration()
    }

    private func collectionConfiguration() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(PopularTableViewCell.cellHeight + 10)
        }
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseIdentifier)
    }
    
    // MARK: - Build methods
    private static func buildFlowLayout() -> UICollectionViewFlowLayout {
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
extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseIdentifier, for: indexPath) as! PopularCell
        
        viewModel.configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode = viewModel.getMovieCode(by: indexPath.row)
        delegate?.didSelectMovie(code: movieCode)
    }
}

