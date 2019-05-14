//
//  DetailView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Properties
    let contentScrollView = UIScrollView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let dateDurationStackView = UIStackView()
    let releaseDateLabel = UILabel()
    let durationLabel = UILabel()
    let averageVoteLabel = UILabel()
    let averageVoteNumberLabel = UILabel()
    let averageVoteProgressView = UIProgressView()
    let overviewLabel = UILabel()
    let plusImageView = UIImageView()
    let plusLabel = UIImageView()
    let shareImageView = UIImageView()
    let shareLabel = UILabel()
    let recomendationLabel = UILabel()
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        contentConfiguration()
        imageConfiguration()
        titleConfiguration()
        dateDurationStackConfiguration()
    }
    
    private func contentConfiguration() {
        addSubview(contentScrollView)
        contentScrollView.frame = self.bounds
        contentScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentScrollView.backgroundColor = UIColor(named: "lightYellow")
    }
    
    private func imageConfiguration() {
        contentScrollView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.5)
        }
        
        imageView.image = UIImage(named: "avatar")
    }
    
    private func titleConfiguration() {
        contentScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        // TODO: - Retirar
        titleLabel.text = "Titulo"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func dateDurationStackConfiguration() {
        contentScrollView.addSubview(dateDurationStackView)
        dateDurationStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.bottom.equalToSuperview().inset(8)
            make.right.lessThanOrEqualToSuperview().inset(8)
            make.height.equalTo(16)
        }
        
        dateDurationStackView.axis = .horizontal
        dateDurationStackView.alignment = .center
        dateDurationStackView.distribution = .fillProportionally
        dateDurationStackView.spacing = 8
        
        releaseDateLabel.text = "Release date"
        durationLabel.text = "Movie duration"
        
        dateDurationStackView.addArrangedSubview(releaseDateLabel)
        dateDurationStackView.addArrangedSubview(durationLabel)
    }
}
