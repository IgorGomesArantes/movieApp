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
    func myList(_ result: ServiceStatus)
    func recomendation(_ result: ServiceStatus)
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
        viewModel.reloadPopular()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeView.tableView.setContentOffset(.zero, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.reloadMyList()
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
        homeView.tableView.register(MyListTableViewCell.self, forCellReuseIdentifier: MyListTableViewCell.reuseIdentifier)
        homeView.tableView.register(RecomendationTableViewCell.self, forCellReuseIdentifier: RecomendationTableViewCell.reuseIdentifier)
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
            homeView.tableView.reloadSections([0], with: .automatic)
        default:
            break
        }
    }
    
    func myList(_ result: ServiceStatus) {
        switch result {
        case .success:
            homeView.tableView.reloadSections([1], with: .automatic)
            homeView.tableView.performBatchUpdates(nil, completion: { result in
                self.viewModel.reloadRecomendations()
            })
        default:
            break
        }
    }
    
    func recomendation(_ result: ServiceStatus) {
        switch result {
        case .success:
            homeView.tableView.reloadSections([2], with: .automatic)
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
        case .popular:
            return 1
            
        case .myList:
            if viewModel.isMyListEmpty() {
                return 0
            } else {
                return 1
            }
        
        case .recomendation:
            if viewModel.isRecomendationEmpty() {
                return 0
            } else {
                return 1
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .popular:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.reuseIdentifier, for: indexPath) as! PopularTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
        
        case .myList:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: MyListTableViewCell.reuseIdentifier, for: indexPath) as! MyListTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
            
        case .recomendation:
            let cell = homeView.tableView.dequeueReusableCell(withIdentifier: RecomendationTableViewCell.reuseIdentifier, for: indexPath) as! RecomendationTableViewCell
            
            viewModel.configureCell(cell)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = viewModel.sections[indexPath.section]
        let width = UIScreen.main.bounds.width
        
        // TODO: - Dinamizar tamanho
        switch sectionType {
        case .popular:
            return (width / 2.0) * 1.5 + 10
        case .myList:
            return (width / 5.0) * 1.5 + 10
        case .recomendation:
            return ((((width / 2.0) - 30) * 0.5 + 15) * 10) + 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableSectionHeaderView()
        headerView.setup(title: constants.sections[section])

        return headerView
    }
}
