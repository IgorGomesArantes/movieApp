//
//  PopularCollectionViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "popularCell"
    var view = PopularView()
    
    func setup(_ viewModel: PopularViewModel) {
        setupHierarchy()
        viewModel.configure(view)
    }
    
    private func setupHierarchy() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
