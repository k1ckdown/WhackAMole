//
//  StartPresenter.swift.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import Foundation


final class StartPresenter {
    weak var view: StartView?
    weak var coordinator: StartCoordinatorProtocol?
    
    required init(view: StartView) {
        self.view = view
    }
}

extension StartPresenter: StartViewPresenter {
    func didGoToGameScreen() {
        coordinator?.showGameScene()
    }
}
