//
//  ResultView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    // MARK: View properties
    let imageView = UIImageView()
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        imageConfiguration()
        shadowConfiguration()
    }
    
    private func imageConfiguration() {
        addSubview(imageView)
        imageView.frame = self.bounds
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }
}
