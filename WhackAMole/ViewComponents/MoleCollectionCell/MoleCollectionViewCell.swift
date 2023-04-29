//
//  MoleCollectionViewCell.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

class MoleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MoleCollectionViewCell"
    
     let moleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(moleImageView)
        
        moleImageView.image = UIImage(named: "Default")
        moleImageView.contentMode = .scaleAspectFit
        
        moleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
