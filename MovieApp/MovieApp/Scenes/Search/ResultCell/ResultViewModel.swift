//
//  ResultViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SDWebImage

class ResultViewModel {
    
    // MARK: - Properties
    let movieCode: Int
    let imagePath: String
    
    
    // MARK: - Initialization methods
    init(movieCode: Int, imagePath: String) {
        self.movieCode = movieCode
        self.imagePath = imagePath
    }
    
    // MARK: - Public methods
    func configure(_ view: ResultView) {
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
    }
}
