//
//  AppCoordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }
    
    override func start() {
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        setupWindow()
        showStartScene()
    }
}

private extension AppCoordinator {
    func setupWindow() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showStartScene() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
