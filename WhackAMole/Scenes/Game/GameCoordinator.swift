//
//  GameCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import UIKit

final class GameCoordinator: BaseCoordinator {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let gameViewController = GameViewController()
        let gamePresenter = GamePresenter(view: gameViewController)
        gameViewController.presenter = gamePresenter
        
        navigationController.pushViewController(gameViewController, animated: true)
    }
}
