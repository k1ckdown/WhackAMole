//
//  GameProtocols.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

protocol GameView: AnyObject {
    func didUpdateCollectionItems(at items: [IndexPath])
}

protocol GameViewPresenter: AnyObject {
    func viewDidAppear()
    func getMoleCount() -> Int
    func didTapOnMole(at item: Int)
    func getMoleImageName(for indexPath: IndexPath) -> String
}
