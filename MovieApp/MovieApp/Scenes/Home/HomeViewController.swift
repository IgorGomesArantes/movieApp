//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - View properties
    private let tableView = UITableView()
    
    // MARK: - Properties
    var viewModel: HomeViewModel?
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfiguration()
        start()
    }
    
    // MARK: - Initialization methods
    private func initialConfiguration() {
        viewModel?.onResponse = onResponse
        tableViewHierarchyConfiguration()
    }
    
    private func start() {
        viewModel?.reload()
    }
    
    // MARK: - Private methods
    private func onResponse(result: HomeViewModel.options) {
        switch result {
        case .popular(let result):
            popularHandle(result: result)
        default:
            break
        }
    }
    
    private func popularHandle(result: ServiceStatus<MoviePage>) {
        switch result {
        case .success(let result):
            break
        default:
            break
        }
    }
    
    private func tableViewHierarchyConfiguration() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
