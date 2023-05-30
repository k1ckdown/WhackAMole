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
                static let insetLeading: CGFloat = 55
                static let cornerRadius: CGFloat = 10
            }
        
            enum CoinImageView {
                static let size: CGFloat = 55
                static let insetTop: CGFloat = 20
                static let insetTrailing: CGFloat = 15
                static let borderWidth: CGFloat = 4
                static let cornerRadius: CGFloat = size / 2
            }
        
            enum TimerProgressWrapperView {
                static let height: CGFloat = 35
                static let width: CGFloat = 120
                static let insetTop: CGFloat = 30
                static let insetTrailing: CGFloat = 15
                static let cornerRadius: CGFloat = 7
            }
        
            enum TimerProgressView {
                static let inset: CGFloat = 6
            }
        
            enum TimerImageView {
                static let size: CGFloat = 50
                static let insetTop: CGFloat = 20
                static let insetTrailing: CGFloat = 12
                static let cornerRadius: CGFloat = size / 2
            }
        
            enum MolesCollectionView {
                static let insetTop: CGFloat = 30
            }
        
    }
    
    private let dataSource: GameViewDataSource
    
    private let scoreLabel = UILabel()
    private let coinImageView = UIImageView()
    
    private let timerImageView = UIImageView()
    private let timerProgressView = UIProgressView()
    private let timerProgressWrapperView = UIView()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setup() {
        setupSuperView()
        setupScoreLabel()
        setupCoinImageView()
        setupTimerProgressWrapperView()
        setupTimerProgressView()
        setupTimerImageView()
        setupMolesCollectionView()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "game-background")
    }
    
    private func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
        scoreLabel.text = "0"
        scoreLabel.font = .scoreTitle
        scoreLabel.textColor = .appBlack
        scoreLabel.textAlignment = .center
        scoreLabel.backgroundColor = .appWhite
        scoreLabel.clipsToBounds = true
        scoreLabel.layer.cornerRadius = Constants.ScoreLabel.cornerRadius
        
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
    
    private func setupTimerProgressWrapperView() {
        view.addSubview(timerProgressWrapperView)
        
        timerProgressWrapperView.backgroundColor = .appWhite
        timerProgressWrapperView.clipsToBounds = true
        timerProgressWrapperView.layer.cornerRadius = Constants.TimerProgressWrapperView.cornerRadius
        
        timerProgressWrapperView.snp.makeConstraints { make in
            make.width.equalTo(Constants.TimerProgressWrapperView.width)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.TimerProgressWrapperView.insetTop)
            make.height.equalTo(Constants.TimerProgressWrapperView.height)
            make.trailing.equalToSuperview().inset(Constants.TimerProgressWrapperView.insetTrailing)
        }
    }
    
    private func setupTimerProgressView() {
        timerProgressWrapperView.addSubview(timerProgressView)
        
        timerProgressView.trackTintColor = .timerTrack
        timerProgressView.progressTintColor = .timerProgress
        timerProgressView.observedProgress = presenter?.gameProgress
        
        timerProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.TimerProgressView.inset)
        }
    }
    
    private func setupTimerImageView() {
        view.addSubview(timerImageView)
        
        timerImageView.image = UIImage(named: "clock")
        timerImageView.contentMode = .scaleAspectFill
        timerImageView.backgroundColor = .appWhite
        timerImageView.layer.cornerRadius = Constants.TimerImageView.cornerRadius
        
        timerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.TimerImageView.size)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.TimerImageView.insetTop)
            make.trailing.equalTo(timerProgressWrapperView.snp.leading).offset(Constants.TimerImageView.insetTrailing)
        }
    }
    
    private func setupMolesCollectionView() {
        view.addSubview(molesCollectionView)
        
        molesCollectionView.backgroundColor = .clear
        
        molesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(Constants.MolesCollectionView.insetTop)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension GameViewController: GameView {
    func updateScoreTitle(_ title: String) {
        scoreLabel.text = title
    }
    
    func refreshCollectionItems(at items: [IndexPath]) {
        UIView.performWithoutAnimation {
            molesCollectionView.reloadItems(at: items)
        }
    }
}
