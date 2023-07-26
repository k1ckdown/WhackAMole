//
//  GameViewInput.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 26.07.2023.
//

import Foundation

protocol GameViewInput: AnyObject {
    func hideResultView()
    func showResultView()
    
    func updateResultTitle(_ title: String)
    func updateGameScoreTitle(_ title: String)
    func updateResultScoreTitle(_ title: String)
    
    func refreshCollection()
    func refreshCollectionItems(at items: [IndexPath])
}
