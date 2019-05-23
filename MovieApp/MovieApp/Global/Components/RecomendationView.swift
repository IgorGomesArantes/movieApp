//
//  RecomendationView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class RecomendationView: UIView {
    
    // MARK: - Constants
    struct Constants {
        
    }
    
    private let constants = Constants()
    
    // MARK: - View properties
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let voteAverageLabel = UILabel()
    let averageVoteProgressView = UIProgressView(progressViewStyle: .bar)
    private let starVoteImageView = UIImageView()
    
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
        viewConfiguration()
        imageConfiguration()
        titleConfiguration()
        progressBarConfiguration()
        starConfiguration()
        voteAverageConfiguration()
    }
    
    private func viewConfiguration() {
        backgroundColor = UIColor.white
    }
    
    private func imageConfiguration() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(imageView.snp.height).dividedBy(1.5)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.borderConfiguration()
    }
    
    private func titleConfiguration() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(5)
            make.left.equalTo(imageView.snp.right).offset(8)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.numberOfLines = 2
    }
    
    private func progressBarConfiguration() {
        addSubview(averageVoteProgressView)
        averageVoteProgressView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(8)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.height.equalTo(1)
        }
        
        averageVoteProgressView.progressTintColor = UIColor(named: "yellow")
        averageVoteProgressView.trackTintColor = UIColor(named: "lightGrey")
    }
    
    private func starConfiguration() {
        addSubview(starVoteImageView)
        starVoteImageView.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.bottom.equalTo(averageVoteProgressView.snp.top).offset(-5)
            make.width.equalTo(averageVoteProgressView.snp.width).multipliedBy(0.15)
            make.height.equalTo(starVoteImageView.snp.width)
        }
        
        starVoteImageView.image = UIImage(named: "star")
        starVoteImageView.contentMode = .scaleAspectFit
    }
    
    private func voteAverageConfiguration() {
        addSubview(voteAverageLabel)
        voteAverageLabel.snp.makeConstraints { make in
            make.left.equalTo(starVoteImageView.snp.right).offset(3)
            make.right.equalToSuperview().inset(8)
            make.centerY.equalTo(starVoteImageView.snp.centerY)
        }
        
        voteAverageLabel.numberOfLines = 1
        voteAverageLabel.font = UIFont.systemFont(ofSize: 9)
        voteAverageLabel.textAlignment = .left
    }
}
