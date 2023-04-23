//
//  GameCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import Foundation
import UIKit

final class GameCoordinator: BaseCoordinator {
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let gameViewController = GameViewController()
        navigationController.pushViewController(gameViewController, animated: true)
    }
}
