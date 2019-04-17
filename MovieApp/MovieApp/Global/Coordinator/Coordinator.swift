//
//  Coordinator.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 17/04/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: class {
    func childDidFinish(_ coordinator: Coordinator)
}

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.removeAll(where: { $0 === childCoordinator })
        childCoordinator.finish()
    }
    
    func finish() {
        self.childCoordinators.removeAll()
    }
}
