//
//  UIViewExtensions.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

extension UIView {
    func shadowConfiguration() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.34
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func borderConfiguration() {
        layer.cornerRadius = 2.0
        layer.masksToBounds = true
    }
}
