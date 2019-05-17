//
//  HomeTableSectionHeaderView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeTableSectionHeaderView: UIView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let width = UIScreen.main.bounds.width
    
    // MARK: - Inititalization methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        viewConfiguration()
        titleConfiguration()
    }
    
    private func viewConfiguration() {
        backgroundColor = UIColor(named: "lightYellow")
    }
    
    private func titleConfiguration() {
        let inset = (width / 100) * 3
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(inset)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
