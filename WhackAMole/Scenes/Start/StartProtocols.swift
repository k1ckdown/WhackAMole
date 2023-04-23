//
//  StartProtocols.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import Foundation

protocol StartView: AnyObject {
    
}

protocol StartViewPresenter: AnyObject {
    func didGoToGameScreen()
}

protocol StartCoordinatorProtocol: Coordinator {
    func showGameScene()
}
