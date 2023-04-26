//
//  GameViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import UIKit

final class GameViewController: BaseViewController {
    
    private enum Constants {
            enum ScoreLabel {
                static let height: CGFloat = 35
                static let width: CGFloat = 120
                static let insetTop: CGFloat = 30
                static let insetLeading: CGFloat = 60
                static let cornerRadius: CGFloat = 10
            }
        
            enum CoinImageView {
                static let size: CGFloat = 55
                static let insetTop: CGFloat = 20
                static let insetTrailing: CGFloat = 15
                static let borderWidth: CGFloat = 4
                static let cornerRadius: CGFloat = size / 2
            }
    }
    
    private let coinImageView = UIImageView()
    private let scoreLabel = UILabel()
    
    private let clockImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        setupSuperView()
        setupScoreLabel()
        setupCoinImageView()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "Frame 2")
    }
    
    private func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        scoreLabel.text = "25"
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        scoreLabel.textAlignment = .center
        scoreLabel.layer.cornerRadius = Constants.ScoreLabel.cornerRadius
        scoreLabel.clipsToBounds = true
        scoreLabel.backgroundColor = .white
        scoreLabel.adjustsFontSizeToFitWidth = true
        
        scoreLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.ScoreLabel.width)
            make.height.equalTo(Constants.ScoreLabel.height)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.ScoreLabel.insetTop)
            make.leading.equalToSuperview().offset(Constants.ScoreLabel.insetLeading)
        }
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
            make.trailing.equalTo(scoreLabel.snp.leading).offset(Constants.CoinImageView.insetTrailing)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.CoinImageView.insetTop)
        }
    }
}
