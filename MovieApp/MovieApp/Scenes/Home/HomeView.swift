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
        tableView.frame = self.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        tableView.backgroundColor = UIColor(named: "lightYellow")
        tableView.separatorStyle = .none
        tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: PopularTableViewCell.reuseIdentifier)
    }
}
