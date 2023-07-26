//
//  StartPresenter.swift.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import Foundation

final class StartPresenter {
    private weak var view: StartViewInput?
    private weak var coordinator: StartCoordinatorProtocol?
    
    init(view: StartViewInput, coordinator: StartCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - StartViewOutput

extension StartPresenter: StartViewOutput {
    
    func didTapOnStartButton() {
        coordinator?.showGameScene()
    }
    
}
