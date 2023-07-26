//
//  TimerImageView.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 31.05.2023.
//

import UIKit

final class TimerImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.width / 2
    }
    
    private func setup() {
        image = UIImage(named: "clock")
        contentMode = .scaleAspectFill
        backgroundColor = .appWhite
    }
}
