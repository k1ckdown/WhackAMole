//
//  GamePresenter.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

final class GamePresenter {
    
    var numberOfMoles: Int {
        game.numberOfMoles
    }
    
    private weak var view: GameView?
    private var moles: [Mole]
    private let game: Game
    private var gameTimer: Timer?
    
    init(view: GameView) {
        self.view = view
        game = .init()
        moles = .init()
        addMoles()
    }
    
    private func startGame() {
        createGameTimer()
    }
    
    private func addMoles() {
        for _ in 1...numberOfMoles {
            moles.append(Mole(hitCount: 0,
                              state: .disappearing))
        }
    }
    
    private func createGameTimer() {
        guard gameTimer == nil else { return }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(applyMoleAppearingState),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func getRandomAvailableIndexMole() -> Int? {
        var availableIndexesMole = [Int]()
        for (index, mole) in moles.enumerated() {
            if mole.state == .disappearing {
                availableIndexesMole.append(index)
            }
        }
        
        return availableIndexesMole.randomElement()
    }
    
    @objc
    private func applyMoleAppearingState() {
        guard let stateType = StateType.allCases.randomElement() else { return }
        guard let indexMole = getRandomAvailableIndexMole() else { return }
        
        moles[indexMole].state = .appearing(type: stateType)
        view?.refreshCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            self.applyMoleDisappearingState(at: indexMole)
        }
    }
    
    private func applyMoleDisappearingState(at indexMole: Int) {
        switch moles[indexMole].state {
        case .appearing(type: _):
            self.moles[indexMole].state = .disappearing
            self.view?.refreshCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        default: return
        }
    }
    
    private func hurtMole(item: Int, stateType: StateType) {
        game.incrementScoreForKill()
        moles[item].state = .hurt(type: stateType)
        
        view?.updateScoreTitle("\(game.score)")
        view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])
        
        if game.isMaxScore {
            gameTimer?.invalidate()
            print("The end")
        }
    }
    
    private func hitMole(item: Int) {
        game.incrementScoreForHit()
        moles[item].state = .hit
        
        view?.updateScoreTitle("\(game.score)")
        view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            self.moles[item].state = .disappearing
            self.view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])
        }
    }
    
}

extension GamePresenter: GameViewPresenter {
    func viewDidAppear() {
        startGame()
    }
    
    func configure(cell: MoleView, forItem item: Int) {
        cell.updateImageView(to: moles[item].state.description)
    }
    
    func didTapOnMole(at item: Int) {
        switch (moles[item].state) {
        case .appearing(type: let type):
            moles[item].hitCount += 1
            
            if (moles[item].hitCount == game.hitsToKillCount) {
                hurtMole(item: item, stateType: type)
            } else {
                hitMole(item: item)
            }
            
        default: return
        }
    }
    
}
