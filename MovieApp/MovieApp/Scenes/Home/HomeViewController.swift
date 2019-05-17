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
    func popular(_ result: ServiceStatus<MoviePage>)
}

class HomeViewController: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        let sections = ["Melhores da semana", "Minha lista", "Recomendações para você"]
    }
    
    let constants = Constants()
    
    // MARK: - Properties
    private var viewModel: HomeViewModel!
    private var homeView = HomeView()
    
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        initialConfiguration()
        viewModel.reload()
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
        homeView.frame = view.bounds
        homeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func tableViewConfiguration() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
        homeView.tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: PopularTableViewCell.reuseIdentifier)
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
    func popular(_ result: ServiceStatus<MoviePage>) {
        switch result {
        case .success:
            homeView.tableView.reloadData()
        default:
            break
        }
    }
}

// MARK: - Collection view delegate and data source methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsBySection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeView.tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.reuseIdentifier, for: indexPath) as! PopularTableViewCell
        
        viewModel.configurePopularCell(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let section = indexPath.section
        
        // TODO: - Dinamizar tamanho
        if section == 0 {
            return (width / 2.0) * 1.5
        } else if section == 1 {
            return width / 2.0
        } else {
            return width * 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableSectionHeaderView()
        headerView.setup(title: constants.sections[section])

        return headerView
    }
}
