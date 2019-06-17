//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: class {
    func popular(_ result: ServiceStatus)
    func topRated(_ result: ServiceStatus)
    func nowPlaying(_ result: ServiceStatus)
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: HomeViewModel!
    private var homeView = HomeView()
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        initialConfiguration()
        self.viewModel.reloadAll()
    }
    
    // MARK: - Initialization methods
    static func instantiate(viewModel: HomeViewModel) -> HomeViewController {
        let homeViewController = HomeViewController()

        homeViewController.viewModel = viewModel
        viewModel.controllerDelegate = homeViewController

        return homeViewController
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        homeViewConfiguration()
        tableViewConfiguration()
        navigationItemConfiguration()
    }
    
    private func homeViewConfiguration() {
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func tableViewConfiguration() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
        homeView.tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: PopularTableViewCell.reuseIdentifier)
        homeView.tableView.register(NowPlayingTableViewCell.self, forCellReuseIdentifier: NowPlayingTableViewCell.reuseIdentifier)
        homeView.tableView.register(TopRatedTableViewCell.self, forCellReuseIdentifier: TopRatedTableViewCell.reuseIdentifier)
    }

    private func navigationItemConfiguration() {
        navigationItem.title = "Home"
        
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonAction))
        navigationItem.rightBarButtonItem = button
    }
    
    // MARK: - Action methods
    @objc private func searchButtonAction() {
        viewModel.search()
    }
}

// MARK: - Home view controller delegate methods
extension HomeViewController: HomeViewControllerDelegate {
    func popular(_ result: ServiceStatus) {
        switch result {
        case .success:
            homeView.tableView.reloadSections([0], with: .none)
        default:
            break
        }
    }
    
    func nowPlaying(_ result: ServiceStatus) {
        switch result {
        case .success:
            homeView.tableView.reloadSections([1], with: .none)
        default:
            break
        }
    }
    
    func topRated(_ result: ServiceStatus) {
        switch result {
        case .success:
            homeView.tableView.reloadSections([2], with: .none)
        default:
            break
        }
    }
}

// MARK: - Collection view delegate and data source methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .popular, .topRated, .nowPlaying:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .popular:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.reuseIdentifier, for: indexPath) as! PopularTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
        
        case .nowPlaying:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.reuseIdentifier, for: indexPath) as! NowPlayingTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
            
        case .topRated:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.reuseIdentifier, for: indexPath) as! TopRatedTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableSectionHeaderView()
        
        viewModel.configureHeader(headerView, section: section)

        return headerView
    }
}
