//
//  BaseCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func coordinate(to coordinator: Coordinator) {
        childCoordinators.append(coordinator)
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

