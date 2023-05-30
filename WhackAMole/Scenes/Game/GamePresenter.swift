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
    
    let gameProgress: Progress
    
    private weak var view: GameView?
    
    private var moles: [Mole]
    private let game: Game
    private var isEndGame = false
    private var gameTimer: Timer?
    
    init(view: GameView) {
        self.view = view
        
        game = .init()
        moles = .init()
        
        gameProgress = .init(totalUnitCount: game.playingTime)
        gameProgress.completedUnitCount = game.playingTime
        
        addMoles()
    }
    
}

private extension GamePresenter {
    
    func startGame() {
        createGameTimer()
    }
    
    func addMoles() {
        for _ in 1...numberOfMoles {
            moles.append(Mole(hitCount: 0,
                              state: .disappearing))
        }
    }
    
    func createGameTimer() {
        guard gameTimer == nil else { return }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(play),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc
    func play() {
        gameProgress.completedUnitCount -= 1
        
        if gameProgress.fractionCompleted == 0 {
            finishGame()
        }
        
        if gameProgress.completedUnitCount % 2 == 0 {
            applyMoleAppearingState()
        }
    }
    
    func finishGame() {
        gameTimer?.invalidate()
        isEndGame = true
        print("The end")
    }
    
    func getRandomAvailableIndexMole() -> Int? {
        var availableIndexesMole = [Int]()
        for (index, mole) in moles.enumerated() {
            if mole.state == .disappearing {
                availableIndexesMole.append(index)
            }
        }
        
        return availableIndexesMole.randomElement()
    }
    
    func hurtMole(item: Int, stateType: StateType) {
        game.incrementScoreForKill()
        moles[item].state = .hurt(type: stateType)
        
        view?.updateScoreTitle("\(game.score)")
        view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])
        
        if game.isMaxScore {
            finishGame()
        }
    }
    
    func hitMole(item: Int) {
        game.incrementScoreForHit()
        moles[item].state = .hit
        
        view?.updateScoreTitle("\(game.score)")
        view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            self.moles[item].state = .disappearing
            self.view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])
        }
    }
    
    func applyMoleDisappearingState(at indexMole: Int) {
        switch moles[indexMole].state {
        case .appearing(type: _):
            self.moles[indexMole].state = .disappearing
            self.view?.refreshCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        default: return
        }
    }
    
    func applyMoleAppearingState() {
        guard isEndGame == false else { return }
        guard let stateType = StateType.allCases.randomElement() else { return }
        guard let indexMole = getRandomAvailableIndexMole() else { return }
        
        moles[indexMole].state = .appearing(type: stateType)
        view?.refreshCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            self.applyMoleDisappearingState(at: indexMole)
        }
    }
    
}

extension GamePresenter: GameViewPresenter {
    
    func viewWillAppear() {
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
