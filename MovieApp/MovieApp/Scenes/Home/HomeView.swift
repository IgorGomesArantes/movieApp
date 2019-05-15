//
//  HomeView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 10/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    // MARK: - View properties
    let contentView = UIView()
    var popularCollectionView: UICollectionView!
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        contentConfiguration()
        popularCollectionConfiguration()
    }
    
    private func contentConfiguration() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = UIColor(named: "lightYellow")
    }
    
    // TODO: - Corrigir tamanho dinamico
    private func popularCollectionConfiguration() {
        let cellHeight = 400
        let cellWidth = (cellHeight / 3) * 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 40
        layout.minimumLineSpacing = 40
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        popularCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        popularCollectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
        
        contentView.addSubview(popularCollectionView)
        popularCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.height).dividedBy(1.5)
        }

        popularCollectionView.backgroundColor = .clear
        popularCollectionView.showsHorizontalScrollIndicator = false
    }
}
