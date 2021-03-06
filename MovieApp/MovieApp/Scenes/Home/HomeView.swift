//
//  HomeView.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 10/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    // MARK: - View properties
    let tableView = UITableView()
    
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
        tableViewConfiguration()
    }

    private func tableViewConfiguration() {
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}
