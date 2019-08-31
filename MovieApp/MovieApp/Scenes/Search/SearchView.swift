//
//  SearchView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - Metadata
    enum State {
        case empty(string: String)
        case error(string: String)
        case loading
        case full
        case blank
    }
    
    // MARK: - Constants
    struct Constants {
        let backGroundColor = UIColor.white//UIColor(named: "lightYellow")
        let mainColor = UIColor(named: "yellow")
        
        let smallSpace = CGFloat(8)
        let collectionDefaultSpace = CGFloat(12)
        let numberOFCellsPerLine = 3
        
        let searchBarPlaceholder = "Buscar"
        let searchBarScopeTitles = ["Todos", "Filmes", "Séries"]
    }
    
    let constants = Constants()
    
    // MARK: - View properties
    let contentView = UIView()
    let searchBar = UISearchBar()
    var resultCollectionView: UICollectionView!
    private let activityIndicatorView = UIActivityIndicatorView()
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let refreshButton = UIButton()
    private let refreshControl = UIRefreshControl()
    
    
    // MARK: - Initialization methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialConfiguration()
        reload(.blank)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        contentConfiguration()
        searchBarConfiguration()
        resultCollectionConfiguration()
        loadingConfiguration()
        stackConfiguration()
        imageConfiguration()
        titleConfiguration()
        refreshButtonConfiguration()
    }
    
    private func contentConfiguration() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.backgroundColor = constants.backGroundColor
    }
    
    private func searchBarConfiguration() {
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(constants.smallSpace)
        }
        
        searchBar.showsScopeBar = true
        searchBar.isTranslucent = true
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        
        searchBar.placeholder = constants.searchBarPlaceholder
        //searchBar.scopeButtonTitles = constants.searchBarScopeTitles
        
        searchBar.barTintColor = constants.backGroundColor
        searchBar.tintColor = constants.mainColor
        UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = constants.mainColor
        
    }
    
    private func resultCollectionConfiguration() {
        let space = constants.collectionDefaultSpace
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        resultCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        contentView.addSubview(resultCollectionView)
        resultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview().inset(space)
        }
        
        resultCollectionView.backgroundColor = constants.backGroundColor
        resultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.reuseIdentifier)
    }
    
    private func loadingConfiguration() {
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        activityIndicatorView.style = .white
        activityIndicatorView.color = .black
    }
    
    private func stackConfiguration() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
    }
    
    private func imageConfiguration() {
        stackView.addArrangedSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        imageView.contentMode = .scaleAspectFit
    }
    
    private func titleConfiguration() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func refreshButtonConfiguration() {
        stackView.addArrangedSubview(refreshButton)
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchDown)
        refreshButton.setTitle("Tentar novamente", for: .normal)
        refreshButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        refreshButton.setTitleColor(.black, for: .normal)
        refreshButton.setTitleColor(.black, for: .highlighted)
    }
    
    // MARK: - Action methods
    @objc private func refreshButtonAction() {
        //tryAgainAction?()
    }
    
    // MARK: - Reload methods
    func reload(_ state: State) {
        switch state {
        case .full:
            fullReload()
            
        case .empty(let string):
            emptyReload(string)
            
        case .error(let string):
            errorReload(string)
            
        case .loading:
            loadingReload()
            
        case .blank:
            blankReload()
        }
    }
    
    private func fullReload() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        stackView.isHidden = true
        
        resultCollectionView.isHidden = false
        resultCollectionView.reloadData()
    }
    
    private func emptyReload(_ string: String) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        resultCollectionView.isHidden = true
        refreshButton.isHidden = true
        
        stackView.isHidden = false
        titleLabel.text = string
        imageView.image = UIImage(named: "")
    }
    
    private func errorReload(_ string: String) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        resultCollectionView.isHidden = true
        
        refreshButton.isHidden = false
        stackView.isHidden = false
        titleLabel.text = string
        imageView.image = UIImage(named: "")
    }
    
    private func loadingReload() {
        stackView.isHidden = true
        resultCollectionView.isHidden = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func blankReload() {
        stackView.isHidden = true
        resultCollectionView.isHidden = true
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: - Cell size properties
    var cellWidth: CGFloat {
        let space = constants.collectionDefaultSpace
        let numberOfCells = CGFloat(constants.numberOFCellsPerLine)
        let numberOfSpaces = CGFloat(4)
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - ((numberOfCells + numberOfSpaces - 1) * space)) / numberOfCells
        
        return cellWidth
    }
    
    var cellHeight: CGFloat {
        let cellHeight = cellWidth * 1.5
        
        return cellHeight
    }
}
