//
//  GamePresenter.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

final class GamePresenter {
    
    private weak var view: GameView?

    private var gameTimer: Timer?
    private var score = 0
    private(set) var numberOfMoles = 12
    private var moles = [Mole]()
    
    init(view: GameView) {
        self.view = view
        
        for _ in 1...numberOfMoles {
            moles.append(Mole(hitCount: 0, hitsToKillCount: 3, state: .disappearing))
        }
    }
    
    private func startGame() {
        createGameTimer()
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
        view?.didUpdateCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            self.applyMoleHideState(at: indexMole)
        }
    }
    
    private func applyMoleHideState(at indexMole: Int) {
        switch moles[indexMole].state {
        case .appearing(type: _):
            self.moles[indexMole].state = .disappearing
            self.view?.didUpdateCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
        default: return
        }
    }
    
}

extension GamePresenter: GameViewPresenter {
    
    func viewDidAppear() {
        startGame()
    }
    
    func getMoleImageName(for indexPath: IndexPath) -> String {
        moles[indexPath.item].state.description
    }
    
    func getMoleCount() -> Int {
        moles.count
    }
    
    func didTapOnMole(at item: Int) {
        switch (moles[item].state) {
        case .appearing(type: let type):
            moles[item].hitCount += 1
            
            if (moles[item].hitCount == moles[item].hitsToKillCount) {
                score += 3
                moles[item].state = .hurt(type: type)
                view?.didUpdateScoreTitle("\(score)")
                view?.didUpdateCollectionItems(at: [IndexPath(item: item, section: 0)])
            } else {
                score += 1
                moles[item].state = .hit
                view?.didUpdateScoreTitle("\(score)")
                view?.didUpdateCollectionItems(at: [IndexPath(item: item, section: 0)])

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    self.moles[item].state = .disappearing
                    self.view?.didUpdateCollectionItems(at: [IndexPath(item: item, section: 0)])
                }
            }
            
        default: return
        }
    }
    
}
