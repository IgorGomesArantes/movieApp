//
//  SearchView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 15/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
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
        searchBarConfiguration()
        resultCollectionConfiguration()
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
        
        searchBar.becomeFirstResponder()
        
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
