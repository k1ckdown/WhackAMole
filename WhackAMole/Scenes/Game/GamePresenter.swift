//
//  GamePresenter.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation
import AVFoundation

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
    private var player: AVAudioPlayer?
    
    private let endTimeTitle = "Time's up!"
    private let winningTitle = "Top scorer!"
    
    init(view: GameView) {
        self.view = view
        
        game = .init()
        moles = .init()
        
        gameProgress = .init(totalUnitCount: game.playingTime)
        
        addMoles()
    }
    
}

private extension GamePresenter {
    
    func startGame() {
        view?.updateGameScoreTitle("\(game.score)")
        
        gameProgress.completedUnitCount = game.playingTime
        startGameTimer()
    }
    
    func addMoles() {
        for _ in 1...numberOfMoles {
            moles.append(Mole(hitCount: 0,
                              state: .disappearing))
        }
    }
    
    func startGameTimer() {
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
        
        view?.displayResultView()
        view?.updateResultTitle(game.isMaxScore ? winningTitle : endTimeTitle)
        view?.updateResultScoreTitle("Your score: \(game.score)")
    }
    
    func playAgain() {
        moles.forEach { $0.state = .disappearing }
        
        view?.hideResultView()
        view?.refreshCollection()
        
        game.resetScore()
        startGame()
        isEndGame = false
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
        
        view?.updateGameScoreTitle("\(game.score)")
        view?.refreshCollectionItems(at: [IndexPath(item: item, section: 0)])
        
        if game.isMaxScore {
            finishGame()
        }
    }
    
    func hitMole(item: Int) {
        game.incrementScoreForHit()
        moles[item].state = .hit
        
        view?.updateGameScoreTitle("\(game.score)")
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

    func playSound() {
        guard let url = Bundle.main.url(forResource: "Pop", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
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
    
    func didTapOnPlayAgain() {
        playAgain()
    }
    
    func didTapOnMole(at item: Int) {
        switch (moles[item].state) {
        case .appearing(type: let type):
            playSound()
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