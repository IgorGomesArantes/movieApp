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

        return homeViewController
    }
    
    // MARK: - Configuration methods
    private func initialConfiguration() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
        homeViewConfiguration()
        navigationItemConfiguration()
    }
    
    private func homeViewConfiguration() {
        view.addSubview(homeView)
        homeView.frame = view.bounds
        homeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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


// MARK: - Collection view delegate and data source methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeView.tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.reuseIdentifier, for: indexPath) as! PopularTableViewCell
        
        viewModel.configurePopularCell(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width
        
        return (width / 2.0) * 1.5 + 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 200))

        headerView.backgroundColor = UIColor(named: "lightYellow")
        
        let titleLabel = UILabel()
        titleLabel.text = "Melhores da semana"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        return headerView
    }
}
