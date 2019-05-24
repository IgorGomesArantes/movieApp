//
//  DetailView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Constants
    struct Constants {
        let verySmallSpace = CGFloat(4)
        let smallSpace = CGFloat(8)
        let mediumSpace = CGFloat(16)
        let bigSpace = CGFloat(24)
        
        let verySmallFontSize = CGFloat(11.0)
        let smallFontSize = CGFloat(13.0)
        let mediumFontSize = CGFloat(15.0)
        let bigFontSize = CGFloat(17.0)
        
        let imageAspectRatio = 1.5
        let voteProgresHeight = CGFloat(3)
    }
    
    let constants = Constants()
    
    // MARK: - View properties
    let contentScrollView = UIScrollView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let dateDurationStackView = UIStackView()
    let releaseDateLabel = UILabel()
    let durationLabel = UILabel()
    let averageVoteLabel = UILabel()
    let averageVoteNumberLabel = UILabel()
    let averageVoteStackView = UIStackView()
    let averageVoteProgressView = UIProgressView(progressViewStyle: .bar)
    let overviewTitleLabel = UILabel() // new
    let overviewLabel = UILabel()
    let curiositiesTitleLabel = UILabel() // new
    let budgetLabel = UILabel() // new
    let revenueLabel = UILabel() // new
    let myListButton = UIButton()
    let myListLabel = UILabel()
    let myListStackView = UIStackView()
    let recomendationTitleLabel = UILabel()
    let recomendationCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func check() {
        myListButton.setImage(UIImage(named: "checked"), for: .normal)
    }
    
    func uncheck() {
        myListButton.setImage(UIImage(named: "blackPlus"), for: .normal)
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        contentConfiguration()
        imageConfiguration()
        titleConfiguration()
        dateDurationStackConfiguration()
        averageVoteConfiguration()
        averageVoteBarConfiguration()
        overviewTitleConfiguration()
        overviewConfiguration()
        curiositiesTitleConfiguration()
        budgetConfiguration()
        revenueConfiguration()
        myListConfiguration()
        recomendationTitleConfiguration()
        recomendationCollectionConfiguration()
    }
    
    private func contentConfiguration() {
        addSubview(contentScrollView)
        contentScrollView.frame = self.bounds
        contentScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.backgroundColor = .white//UIColor(named: "lightYellow")
    }
    
    private func imageConfiguration() {
        contentScrollView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(imageView.snp.width).multipliedBy(constants.imageAspectRatio)
        }
    }
    
    private func titleConfiguration() {
        contentScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(constants.bigSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: constants.bigFontSize)
    }
    
    private func dateDurationStackConfiguration() {
        contentScrollView.addSubview(dateDurationStackView)
        dateDurationStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(constants.bigSpace)
            make.left.equalToSuperview().inset(constants.smallSpace)
            make.right.lessThanOrEqualToSuperview().inset(constants.smallSpace)
        }
        
        dateDurationStackView.axis = .horizontal
        dateDurationStackView.alignment = .center
        dateDurationStackView.distribution = .fillProportionally
        dateDurationStackView.spacing = constants.smallSpace
        
        dateDurationStackView.addArrangedSubview(releaseDateLabel)
        dateDurationStackView.addArrangedSubview(durationLabel)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: constants.smallFontSize)
        durationLabel.font = UIFont.systemFont(ofSize: constants.smallFontSize)
    }
    
    private func averageVoteConfiguration() {
        contentScrollView.addSubview(averageVoteStackView)
        averageVoteStackView.snp.makeConstraints { make in
            make.top.equalTo(dateDurationStackView.snp.bottom).offset(constants.verySmallSpace)
            make.left.equalToSuperview().inset(constants.smallSpace)
            make.right.lessThanOrEqualToSuperview().inset(constants.smallSpace)
        }
        
        averageVoteStackView.axis = .horizontal
        averageVoteStackView.alignment = .center
        averageVoteStackView.distribution = .fillProportionally
        averageVoteStackView.spacing = constants.verySmallSpace
        
        averageVoteStackView.addArrangedSubview(averageVoteLabel)
        averageVoteStackView.addArrangedSubview(averageVoteNumberLabel)
        
        averageVoteLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
        averageVoteNumberLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
    }
    
    private func averageVoteBarConfiguration() {
        contentScrollView.addSubview(averageVoteProgressView)
        averageVoteProgressView.snp.makeConstraints { make in
            make.top.equalTo(averageVoteStackView.snp.bottom).offset(constants.verySmallSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
            make.height.equalTo(constants.voteProgresHeight)
        }
        
        averageVoteProgressView.progressTintColor = UIColor(named: "yellow")
        averageVoteProgressView.trackTintColor = UIColor(named: "lightGrey")
    }
    
    private func overviewTitleConfiguration() {
        contentScrollView.addSubview(overviewTitleLabel)
        overviewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(averageVoteProgressView.snp.bottom).offset(constants.bigSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        overviewTitleLabel.numberOfLines = 1
        overviewTitleLabel.font = UIFont.systemFont(ofSize: constants.mediumFontSize)
        overviewTitleLabel.text = "Resumo"
    }
    
    private func overviewConfiguration() {
        contentScrollView.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(constants.smallSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
    }
    
    private func curiositiesTitleConfiguration() {
        contentScrollView.addSubview(curiositiesTitleLabel)
        curiositiesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(constants.mediumSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        curiositiesTitleLabel.numberOfLines = 1
        curiositiesTitleLabel.font = UIFont.systemFont(ofSize: constants.mediumFontSize)
        curiositiesTitleLabel.text = "Curiosidades"
    }
    
    private func budgetConfiguration() {
        contentScrollView.addSubview(budgetLabel)
        budgetLabel.snp.makeConstraints { make in
            make.top.equalTo(curiositiesTitleLabel.snp.bottom).offset(constants.smallSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        budgetLabel.numberOfLines = 1
        budgetLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
    }
    
    private func revenueConfiguration() {
        contentScrollView.addSubview(revenueLabel)
        revenueLabel.snp.makeConstraints { make in
            make.top.equalTo(budgetLabel.snp.bottom).offset(constants.smallSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        revenueLabel.numberOfLines = 1
        revenueLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
    }
    
    private func myListConfiguration() {
        contentScrollView.addSubview(myListStackView)
        myListStackView.snp.makeConstraints { make in
            make.top.equalTo(revenueLabel.snp.bottom).offset(constants.mediumSpace)
            make.left.equalToSuperview().inset(constants.smallSpace)
        }
        
        myListStackView.axis = .vertical
        myListStackView.alignment = .center
        myListStackView.distribution = .fillProportionally
        
        myListStackView.addArrangedSubview(myListButton)
        myListStackView.addArrangedSubview(myListLabel)
        
        myListButton.snp.makeConstraints { make in
            make.width.equalTo(contentScrollView.snp.width).dividedBy(15)
            make.height.equalTo(myListButton.snp.width)
        }
        
        myListLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
        
        myListLabel.font = UIFont.systemFont(ofSize: 8)
        myListLabel.text = "Minha lista"
    }
    
    private func recomendationTitleConfiguration() {
        contentScrollView.addSubview(recomendationTitleLabel)
        recomendationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(myListStackView.snp.bottom).offset(constants.bigSpace)
            make.left.right.equalToSuperview().inset(constants.smallSpace)
        }
        
        recomendationTitleLabel.font = UIFont.systemFont(ofSize: 13)
        recomendationTitleLabel.text = "Títulos semelhantes"
        recomendationTitleLabel.textAlignment = .left
    }
    
    private func recomendationCollectionConfiguration() {
        recomendationCollection.collectionViewLayout = buildFlowLayout()
        
        contentScrollView.addSubview(recomendationCollection)
        recomendationCollection.snp.makeConstraints { make in
            make.top.equalTo(recomendationTitleLabel.snp.bottom).offset(constants.smallSpace)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(constants.smallSpace)
            make.height.equalTo(1)
        }
        
        recomendationCollection.backgroundColor = .clear
        recomendationCollection.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Build methods
    private func buildFlowLayout() -> UICollectionViewFlowLayout {
        let cellWidth = (UIScreen.main.bounds.width / 2.0) - 20
        let cellHeight = cellWidth * 0.5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return layout
    }
    
    // MARK: - Update methods
    override func updateConstraints() {
        let height = recomendationCollection.collectionViewLayout.collectionViewContentSize.height
        recomendationCollection.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        super.updateConstraints()
    }
}
