//
//  StartPresenter.swift.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import Foundation

final class StartPresenter {
    private weak var view: StartView?
    private weak var coordinator: StartCoordinatorProtocol?
    
    init(view: StartView, coordinator: StartCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension StartPresenter: StartViewPresenter {
    func didGoToGameScreen() {
        coordinator?.showGameScene()
    }
}
