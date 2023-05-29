//
//  Game.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.05.2023.
//

import Foundation

class Game {
    
    private(set) var score = 0
    private(set) var scoresForHit = 1
    private(set) var scoresForKill = 3
    private(set) var hitsToKillCount = 3
    private(set) var numberOfMoles = 3

    var isMaxScore: Bool {
        score ==  numberOfMoles * (scoresForKill + scoresForHit * (hitsToKillCount - 1))
    }
    
    func incrementScoreForHit() {
        score += scoresForHit
    }
    
    func incrementScoreForKill() {
        score += scoresForKill
    }
    
}
