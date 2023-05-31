//
//  ResultGameLabel.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 31.05.2023.
//

import UIKit

final class ResultGameLabel: UILabel {

    init(style: ResultGameLabelStyle) {
        super.init(frame: .zero)
        setup(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(style: ResultGameLabelStyle) {
        font = style.font
        textColor = .appWhite
        textAlignment = .center
        backgroundColor = .clear
    }
    
}
