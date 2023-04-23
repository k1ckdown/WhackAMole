//
//  BaseCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var rootCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func coordinate(to coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.rootCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach{ $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
    
    func didFinish(coordintor: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordintor }) {
            childCoordinators.remove(at: index)
        }
    }
}

