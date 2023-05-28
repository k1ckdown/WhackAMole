//
//  GameViewDataSource.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

final class GameViewDataSource: NSObject {
    var presenter: GameViewPresenter?
    
    func configure(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoleCollectionViewCell.self, forCellWithReuseIdentifier: MoleCollectionViewCell.identifier)
    }
}

extension GameViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getMoleCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoleCollectionViewCell.identifier, for: indexPath) as? MoleCollectionViewCell else {
            return MoleCollectionViewCell()
        }
        
        cell.updateImageView(to: presenter?.getMoleImageName(for: indexPath) ?? "")
        
        return cell
    }
}

extension GameViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTapOnMole(at: indexPath.item)
    }
}
