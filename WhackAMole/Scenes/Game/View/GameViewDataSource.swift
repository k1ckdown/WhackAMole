//
//  GameViewDataSource.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

final class GameViewDataSource: NSObject {
    var presenter: GameViewPresenter?
    
    init(presenter: GameViewPresenter?) {
        self.presenter = presenter
    }
    
    func configure(for collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoleCollectionViewCell.self, forCellWithReuseIdentifier: MoleCollectionViewCell.identifier)
    }
}

extension GameViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoleCollectionViewCell.identifier, for: indexPath) as? MoleCollectionViewCell else {
            return MoleCollectionViewCell()
        }
        
        return cell
    }
}

extension GameViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(collectionView.cellForItem(at: indexPath))
//        if let cv = collectionView.cellForItem(at: indexPath) as? MoleCollectionViewCell {
//            cv.moleImageView.image = UIImage(named: "mole-appearing3")
//        }
    }
}
