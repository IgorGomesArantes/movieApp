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
        let buttonWidthSize = CGFloat(35)
        let buttonHeightSize = CGFloat(40)
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
    let overviewLabel = UILabel()
    let myListButton = UIButton()
    
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
        averageVoteConfiguration()
        averageVoteBarConfiguration()
        overviewConfiguration()
        //myListButtonConfiguration()
        //mockConfiguration()
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
    
    private func overviewConfiguration() {
        contentScrollView.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(averageVoteProgressView.snp.bottom).offset(constants.bigSpace)
            make.left.right.bottom.equalToSuperview().inset(constants.smallSpace)
        }
        
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: constants.verySmallFontSize)
    }
    
    // TODO: - Corrigir
    private func myListButtonConfiguration() {
        contentScrollView.addSubview(myListButton)
        myListButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(constants.smallSpace)
            make.left.equalToSuperview().inset(constants.smallSpace)
            make.height.width.equalTo(constants.buttonWidthSize)
            //make.width.equalTo(constants.buttonHeightSize)
        }
        
        myListButton.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        myListButton.setImage(UIImage(named: "blackPlus"), for: .normal)
        myListButton.setTitle("Minha Lista", for: .normal)
        myListButton.setTitleColor(.black, for: .normal)
        myListButton.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        myListButton.titleEdgeInsets = UIEdgeInsets(top: constants.buttonWidthSize, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    // MARK: - Mock methods
    private func mockConfiguration() {
        imageView.image = UIImage(named: "avengers")
        titleLabel.text = "Avengers: EndGame"
        releaseDateLabel.text = "11 de Março de 2019"
        durationLabel.text = "128 min"
        averageVoteLabel.text = "Nota geral:"
        averageVoteNumberLabel.text = "7.4"
        averageVoteProgressView.setProgress(0.74, animated: false)
        overviewLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae neque gravida, sagittis leo quis, fringilla ipsum. Proin commodo, augue eu egestas pulvinar, elit elit ullamcorper eros, vel mollis ligula elit sed augue. Aliquam pharetra ligula a sem rhoncus faucibus. Donec ut nisi id risus dignissim viverra a ac ex. Fusce sem turpis, facilisis at fringilla ut, molestie ac dolor. Sed efficitur, velit consectetur pharetra lacinia, nibh quam egestas lorem, vitae auctor leo arcu dignissim felis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi pharetra, lectus a cursus fermentum, tortor neque lacinia orci, non blandit ex neque id justo. Proin sit amet venenatis dui, quis suscipit dolor. Donec pharetra lorem sit amet auctor vulputate. Proin nec placerat dolor. Nullam hendrerit vel tortor quis pharetra. Suspendisse blandit hendrerit auctor. Suspendisse potenti. Mauris ac dictum tortor."
    }
}
