//
//  GameViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import UIKit

final class GameViewController: BaseViewController {
    
    var presenter: GameViewPresenter? {
        didSet {
            dataSource.presenter = presenter
        }
    }
    
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
    
    private let dataSource: GameViewDataSource
    
    private let coinImageView = UIImageView()
    private let scoreLabel = UILabel()
    
    private let clockImageView = UIImageView()
    
    private lazy var molesCollectionView: UICollectionView = {
        let layout = MoleLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    init() {
        dataSource = GameViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        dataSource.configure(with: molesCollectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setup() {
        setupSuperView()
        setupScoreLabel()
        setupCoinImageView()
        setupMolesCollectionView()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "game-background")
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
    
    private func setupMolesCollectionView() {
        view.addSubview(molesCollectionView)
        
        molesCollectionView.backgroundColor = .clear
        
        molesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(60)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension GameViewController: GameView {
    func didUpdateCollectionItems(at items: [IndexPath]) {
        UIView.performWithoutAnimation {
            molesCollectionView.reloadItems(at: items)
        }
    }
}
