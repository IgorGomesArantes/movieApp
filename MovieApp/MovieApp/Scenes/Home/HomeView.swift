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
    
    // MARK: - Constants
    struct Constants {
        let smallSpace = CGFloat(8)
        let collectionDefaultSpace = CGFloat(20)
        
        let backGroundColor = UIColor(named: "lightYellow")
        
        let popularCellScreenProportion = CGFloat(2)
    }
    
    private let constants = Constants()
    
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
        
        contentView.backgroundColor = constants.backGroundColor
    }
    
    // TODO: - Corrigir tamanho dinamico
    private func popularCollectionConfiguration() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: constants.collectionDefaultSpace, bottom: 0, right: constants.collectionDefaultSpace)
        layout.minimumInteritemSpacing = constants.collectionDefaultSpace
        layout.minimumLineSpacing = constants.collectionDefaultSpace
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        popularCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        popularCollectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
        
        contentView.addSubview(popularCollectionView)
        popularCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(constants.smallSpace)
            make.left.right.equalToSuperview()
            make.height.equalTo(cellHeight)
        }

        popularCollectionView.backgroundColor = .clear
        popularCollectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Cell size properties
    var cellWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth / constants.popularCellScreenProportion
        
        return cellWidth
    }
    
    var cellHeight: CGFloat {
        let cellHeight = cellWidth * 1.5
        
        return cellHeight
    }
}
