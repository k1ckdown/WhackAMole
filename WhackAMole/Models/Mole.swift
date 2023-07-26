//
//  Mole.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

final class Mole {
    var hitCount: Int
    var state: MoleState
    
    init(hitCount: Int, state: MoleState) {
        self.hitCount = hitCount
        self.state = state
    }
}
