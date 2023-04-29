//
//  GamePresenter.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

final class GamePresenter {
    private weak var view: GameView?
//    private var moles: [MoleState]
    
    init(view: GameView) {
        self.view = view
        
        
    }
    
}

extension GamePresenter: GameViewPresenter {
    func viewDidLoad() {

    }
}
