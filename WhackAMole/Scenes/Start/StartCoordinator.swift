//
//  StartCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import Foundation
import UIKit

final class StartCoordinator: BaseCoordinator {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let startViewController = StartViewController()
        let startPresenter = StartPresenter(view: startViewController)
        
        startPresenter.coordinator = self
        startViewController.presenter = startPresenter
        
        navigationController.setViewControllers([startViewController], animated: true)
    }
}

extension StartCoordinator: StartCoordinatorProtocol {
    func showGameScene() {
        let gameCoordinator = GameCoordinator(navigationController: navigationController)
        coordinate(to: gameCoordinator)
    }
}

