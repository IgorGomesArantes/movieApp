//
//  PopularViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 10/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SDWebImage

class PopularViewModel {
    
    // MARK: - Properties
    let movieCode: Int
    let imagePath: String
    let voteAverage: Float
    
    // MARK: - Initialization methods
    init(movieCode: Int, imagePath: String, voteAverage: Float) {
        self.movieCode = movieCode
        self.imagePath = imagePath
        self.voteAverage = voteAverage
    }
    
    // MARK: - Public methods
    func configure(_ view: PopularView) {
        view.voteAverageLabel.text = String(voteAverage)
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
    }
}

