//
//  MoleLayout.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

final class MoleLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        minimumLineSpacing = 25
        minimumInteritemSpacing = 15
        
        sectionInset.left = 10
        sectionInset.right = sectionInset.left
        
        let itemsInRow: CGFloat = 3
        let sideInset = sectionInset.left * 2
        let lineInset = minimumInteritemSpacing * (itemsInRow - 1) + sideInset
        let availableSpace = collectionView.bounds.width - lineInset
        
        let cellSize = availableSpace / itemsInRow * 0.98
        itemSize = CGSize(width: cellSize, height: cellSize)
    }

}
