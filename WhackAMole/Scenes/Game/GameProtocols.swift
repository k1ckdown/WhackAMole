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
    
    func viewDidAppear()
    func didTapOnMole(at item: Int)
    func configure(cell: MoleView, forItem item: Int)
}
