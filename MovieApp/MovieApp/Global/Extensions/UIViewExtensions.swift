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
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width:0,height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false;
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func borderConfiguration() {
        layer.cornerRadius = 2.0
        layer.masksToBounds = true
    }
}
