//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    struct InitializationData {
        let navigationController: UINavigationController
    }
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController { return UIViewController() }
    
    let navigationController: UINavigationController
    
    init(_ initializationData: InitializationData) {
        self.navigationController = initializationData.navigationController
    }
    
    func start() {
        navigationController.present(rootViewController, animated: true, completion: nil)
    }
}
