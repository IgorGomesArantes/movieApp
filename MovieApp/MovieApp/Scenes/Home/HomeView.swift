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
    //let popularCollectionView = UICollectionView()
    
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
        
        contentView.backgroundColor = UIColor(named: "lightGrey")
    }
    
    private func popularCollectionConfiguration() {
//        contentView.addSubview(popularCollectionView)
//        popularCollectionView.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(contentView.snp.height).dividedBy(2)
//        }
//
//        popularCollectionView.showsVerticalScrollIndicator = false
//        popularCollectionView.showsHorizontalScrollIndicator = true
    }
}
