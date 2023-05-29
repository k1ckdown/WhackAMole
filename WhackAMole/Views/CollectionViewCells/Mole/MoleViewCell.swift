//
//  MoleViewCell.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import UIKit

final class MoleViewCell: UICollectionViewCell, ReuseIdentifier {
    
    private let moleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(moleImageView)
        
        moleImageView.contentMode = .scaleAspectFit
        moleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension MoleViewCell: MoleView {
    func updateImageView(to imageName: String) {
        moleImageView.image = UIImage(named: imageName)
    }
}

