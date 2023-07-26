//
//  GameViewDataSource.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

final class GameViewDataSource: NSObject {
    var output: GameViewOutput!
    
    func configure(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.register(MoleViewCell.self, forCellWithReuseIdentifier: MoleViewCell.reuseIdentifier)
    }
}

extension GameViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.numberOfMoles
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoleViewCell.reuseIdentifier,
                for: indexPath
            ) as? MoleViewCell
        else { return .init() }
        
        output.configure(cell: cell, forItem: indexPath.item)
        return cell
    }
}
