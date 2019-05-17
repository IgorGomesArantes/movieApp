//
//  PopularCollectionViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "popularCell"
    var viewModel: PopularViewModel!
    var view = PopularView()
    
    // MARK: - Public methods
    func setup(movieCode: Int, imagePath: String, voteAverage: Float) {
        hierarchyConfiguration()
        
        viewModel = PopularViewModel(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverage)
        
        viewModel.configure(view)
    }
    
    // MARK: - Configuration methods
    private func hierarchyConfiguration() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
