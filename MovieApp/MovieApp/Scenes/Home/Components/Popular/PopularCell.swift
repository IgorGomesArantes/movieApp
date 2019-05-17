//
//  PopularCollectionViewCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "popularCell"
    private var view = PopularView()
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hierarchyConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(movieCode: Int, imagePath: String, voteAverage: Float) {
        view.voteAverageLabel.text = String(voteAverage)
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
    }
    
    // MARK: - Configuration methods
    private func hierarchyConfiguration() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
