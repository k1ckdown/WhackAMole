//
//  GameViewOutput.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 26.07.2023.
//

import Foundation

protocol GameViewOutput: AnyObject {
    var numberOfMoles: Int { get }
    var gameProgress: Progress { get }
    var playAgainTitle: String { get }
    
    func viewWillAppear()
    func didTapOnPlayAgain()
    func didTapOnMole(at item: Int)
    func configure(cell: MoleView, forItem item: Int)
}
