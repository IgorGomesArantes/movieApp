//
//  ResultCollctionViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "resultCell"
    var view = ResultView()
    
    func setup(_ viewModel: ResultViewModel) {
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

