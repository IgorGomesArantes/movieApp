//
//  RecomendationCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class RecomendationCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "recomendationCell"
    private var view = RecomendationView()
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(movieCode: Int, imagePath: String, voteAverage: Float, title: String) {
        view.voteAverageLabel.text = String(voteAverage)
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
        view.titleLabel.text = title
        view.averageVoteProgressView.progress = voteAverage / 10.0
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        viewConfiguration()
        shadowConfiguration(0.2)
    }
    
    private func viewConfiguration() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
