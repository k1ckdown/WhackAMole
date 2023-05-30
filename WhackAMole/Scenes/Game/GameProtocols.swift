//
//  GameProtocols.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

protocol GameView: AnyObject {
    func updateScoreTitle(_ title: String)
    func refreshCollectionItems(at items: [IndexPath])
}

protocol GameViewPresenter: AnyObject {
    var numberOfMoles: Int { get }
    var gameProgress: Progress { get }
    
    func viewWillAppear()
    func didTapOnMole(at item: Int)
    func configure(cell: MoleView, forItem item: Int)
}
