//
//  UIViewExtensions.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

extension UIView {
    func shadowConfiguration(_ opacity: Float = 0.34) {
        layer.cornerRadius = 3
        layer.shadowRadius = 3
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    func borderConfiguration() {
        layer.cornerRadius = 3
        clipsToBounds = true
    }
}
