//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 22/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        homeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        homeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        homeView.setup()
    }
    
}
