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
                                         selector: #selector(updateMoleState),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func getRandomAvailableIndexMole() -> Int {
        
        var index: Int
        while true {
            index = Int.random(in: 0..<numberOfMoles)
            
            if (moles[index].state == .disappearing) {
                return index
            }
        }
    }
    
    @objc
    private func updateMoleState() {
        guard let stateType = StateType.allCases.randomElement() else { return }
        
        let indexMole = getRandomAvailableIndexMole()
        moles[indexMole].state = .appearing(type: stateType)
        view?.didUpdateCollectionItems(at: [IndexPath(item: indexMole, section: 0)])
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
                moles[item].state = .hurt(type: type)
                view?.didUpdateCollectionItems(at: [IndexPath(item: item, section: 0)])
            } else {
                moles[item].state = .hit
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
