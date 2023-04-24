//
//  GameViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import UIKit

final class GameViewController: BaseViewController {
    
    private enum Constants {
            enum CoinImageView {
                static let size: CGFloat = 55
                static let insetTopLeft: CGFloat = 20
                static let borderWidth: CGFloat = 4
                static let cornerRadius: CGFloat = size / 2
            }
    }
    
    private let coinImageView = UIImageView()
    private let clockImageView = UIImageView()
    
    private let scoreLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        setupSuperView()
        setupCoinImageView()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "Frame 2")
    }
    
    private func setupCoinImageView() {
        view.addSubview(coinImageView)
        
        coinImageView.image = UIImage(named: "coin")
        coinImageView.contentMode = .scaleAspectFill
        
        coinImageView.layer.borderWidth = Constants.CoinImageView.borderWidth
        coinImageView.layer.cornerRadius = Constants.CoinImageView.cornerRadius
        coinImageView.layer.borderColor = UIColor.appWhite?.cgColor
        
        coinImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.CoinImageView.size)
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(Constants.CoinImageView.insetTopLeft)
        }
    }
}
