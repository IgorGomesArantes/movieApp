//
//  MyListCell.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 21/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class MyListCell: UICollectionViewCell {
    
    // MARK: - View properties
    static let reuseIdentifier = "myListCell"
    let imageView = UIImageView()
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(_ imagePath: String) {
        imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
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
        imageView.clipsToBounds = true
    }
    
    private func shadowConfiguration() {
        layer.cornerRadius = 6
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.34
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
