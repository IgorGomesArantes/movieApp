//
//  PopularView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 02/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class PopularView: UIView {
    
    // MARK: - View properties
    let imageView = UIImageView()
    let voteAverageLabel = UILabel()
    private let contentVoteView = UIView()
    private let contentPlusView = UIView()
    private let plusImageView = UIImageView()
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
        imageConfiguration()
//        contentVoteConfiguration()
//        starVoteIconConfiguration()
//        voteAverageConfiguration()
    }
    
    private func imageConfiguration() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
    }
    
    private func contentVoteConfiguration() {
        imageView.addSubview(contentVoteView)
        contentVoteView.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(8)
            make.width.lessThanOrEqualTo(imageView.snp.width).dividedBy(2)
            make.height.equalTo(20)
        }
        
        contentVoteView.backgroundColor = UIColor(named: "transparentGrey")
        contentVoteView.layer.cornerRadius = 3
        contentVoteView.clipsToBounds = true
    }
    
    private func starVoteIconConfiguration() {
        contentVoteView.addSubview(starVoteImageView)
        starVoteImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(3)
            make.width.equalTo(19)
        }
        
        starVoteImageView.contentMode = .scaleAspectFit
        starVoteImageView.image = UIImage(named: "star")
    }
    
    private func voteAverageConfiguration() {
        contentVoteView.addSubview(voteAverageLabel)
        voteAverageLabel.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(3)
            make.left.equalTo(starVoteImageView.snp.right).offset(3)
        }
        
        voteAverageLabel.font = UIFont.boldSystemFont(ofSize: 14)
        voteAverageLabel.textColor = .white
    }
    
    private func contentPlusConfiguration() {
        imageView.addSubview(contentPlusView)
        contentPlusView.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
            make.height.width.equalTo(50)
        }
        
        contentPlusView.backgroundColor = UIColor(named: "transparentGrey")
        contentPlusView.layer.cornerRadius = 6
        contentPlusView.clipsToBounds = true
    }
    
    private func plusIconConfiguration() {
        contentPlusView.addSubview(plusImageView)
        plusImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(7)
        }
        
        plusImageView.image = UIImage(named: "whitePlus")
    }
}
