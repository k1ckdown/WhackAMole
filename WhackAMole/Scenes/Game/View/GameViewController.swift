//
//  GameViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 24.04.2023.
//

import UIKit

final class GameViewController: BaseViewController {
    
    var output: GameViewOutput? {
        didSet {
            dataSource.output = output
        }
    }
    
    private let dataSource: GameViewDataSource
    
    private let scoreLabel = UILabel()
    private let coinImageView = UIImageView()
    
    private let clockImageView = UIImageView()
    private let gameTimerImageView = TimerImageView()
    private let timerProgressView = UIProgressView()
    private let timerProgressWrapperView = UIView()
    
    private let resultView = UIView()
    private let resultWrapperView = UIView()
    private let resultWindowView = UIView()
    private let resultTimerImageView = TimerImageView()
    private let resultScoreLabel = ResultGameLabel(style: .score)
    private let resultTitleLabel = ResultGameLabel(style: .title)
    private let playAgainButton = UIButton(type: .system)
    
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
        output?.viewWillAppear()
    }
    
    @objc
    private func handlePlayAgainButton() {
        output?.didTapOnPlayAgain()
    }
    
    private func setup() {
        setupSuperView()
        setupScoreLabel()
        setupCoinImageView()
        setupTimerProgressWrapperView()
        setupTimerProgressView()
        setupGameTimerImageView()
        setupMolesCollectionView()
        setupResultView()
        setupResultWrapperView()
        setupResulWindowView()
        setupResultTimerImageView()
        setupResultTitleLabel()
        setupResultScoreLabel()
        setupPlayAgainButton()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "game-background")
    }
    
    private func setupScoreLabel() {
        view.addSubview(scoreLabel)
        
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
        timerProgressView.observedProgress = output?.gameProgress
        
        timerProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.TimerProgressView.inset)
        }
    }
    
    private func setupGameTimerImageView() {
        view.addSubview(gameTimerImageView)
        
        gameTimerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.GameTimerImageView.size)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.GameTimerImageView.insetTop)
            make.trailing.equalTo(timerProgressWrapperView.snp.leading).offset(Constants.GameTimerImageView.insetTrailing)
        }
    }
    
    private func setupMolesCollectionView() {
        view.addSubview(molesCollectionView)
        
        molesCollectionView.backgroundColor = .clear
        molesCollectionView.delegate = self
        
        molesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(Constants.MolesCollectionView.insetTop)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupResultView() {
        view.addSubview(resultView)
        
        resultView.isHidden = true
        resultView.backgroundColor = .timerTrack?.withAlphaComponent(0.8)
        
        resultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupResultWrapperView() {
        resultView.addSubview(resultWrapperView)
        
        resultWrapperView.backgroundColor = .appWhite
        resultWrapperView.layer.cornerRadius = Constants.ResultWindowView.cornerRadius
        
        resultWrapperView.snp.makeConstraints { make in
            make.width.equalTo(Constants.ResultWindowView.width)
            make.height.equalTo(Constants.ResultWindowView.height)
            make.center.equalToSuperview()
        }
    }
    
    private func setupResulWindowView() {
        resultWrapperView.addSubview(resultWindowView)
        
        resultWindowView.backgroundColor = .timerProgress
        resultWindowView.layer.borderWidth = Constants.ResultWindowView.borderWidth
        resultWindowView.layer.borderColor = UIColor.timerTrack?.cgColor
        resultWindowView.layer.cornerRadius = Constants.ResultWindowView.cornerRadius
        
        resultWindowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.ResultWindowView.inset)
        }
    }
    
    private func setupResultTimerImageView() {
        resultWindowView.addSubview(resultTimerImageView)
        
        resultTimerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.ResultTimerImageView.size)
            make.top.equalToSuperview().offset(Constants.ResultTimerImageView.insetTop)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupResultTitleLabel() {
        resultWindowView.addSubview(resultTitleLabel)
        
        resultTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(resultTimerImageView.snp.bottom).offset(Constants.ResultTitleLabel.insetTop)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupResultScoreLabel() {
        resultWindowView.addSubview(resultScoreLabel)
        
        resultScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(resultTitleLabel.snp.bottom).offset(Constants.ResultScoreLabel.insetTop)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func setupPlayAgainButton() {
        resultWindowView.addSubview(playAgainButton)
        
        playAgainButton.setTitle(output?.playAgainTitle, for: .normal)
        playAgainButton.titleLabel?.font = .playAgainTitle
        playAgainButton.setTitleColor(.appWhite, for: .normal)
        playAgainButton.backgroundColor = .playAgainButton
        playAgainButton.clipsToBounds = true
        playAgainButton.layer.cornerRadius = Constants.PlayAgainButton.cornerRadius
        playAgainButton.addTarget(self, action: #selector(handlePlayAgainButton), for: .touchUpInside)
        
        playAgainButton.snp.makeConstraints { make in
            make.top.equalTo(resultScoreLabel.snp.bottom).offset(Constants.PlayAgainButton.insetTop)
            make.width.equalTo(Constants.PlayAgainButton.width)
            make.height.equalTo(Constants.PlayAgainButton.height)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - GameViewInput

extension GameViewController: GameViewInput {
    
    func showResultView() {
        resultView.isHidden = false
    }
    
    func hideResultView() {
        resultView.isHidden = true
    }
    
    func refreshCollection() {
        molesCollectionView.reloadData()
    }
    
    func updateResultTitle(_ title: String) {
        resultTitleLabel.text = title
    }
    
    func updateResultScoreTitle(_ title: String) {
        resultScoreLabel.text = title
    }
    
    func updateGameScoreTitle(_ title: String) {
        scoreLabel.text = title
    }
    
    func refreshCollectionItems(at items: [IndexPath]) {
        UIView.performWithoutAnimation {
            molesCollectionView.reloadItems(at: items)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didTapOnMole(at: indexPath.item)
    }
    
}

private extension GameViewController {
    
    enum Constants {
        
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
        
            enum GameTimerImageView {
                static let size: CGFloat = 50
                static let insetTop: CGFloat = 20
                static let insetTrailing: CGFloat = 12
            }
        
            enum MolesCollectionView {
                static let insetTop: CGFloat = 30
            }
        
            enum ResultWindowView {
                static let width: CGFloat = 300
                static let height: CGFloat = 380
                static let inset: CGFloat = 7
                static let borderWidth: CGFloat = 10
                static let cornerRadius: CGFloat = 30
            }
        
            enum ResultTimerImageView {
                static let size: CGFloat = 70
                static let insetTop: CGFloat = 50
            }
        
            enum ResultTitleLabel {
                static let insetTop: CGFloat = 30
            }
        
            enum ResultScoreLabel {
                static let insetTop: CGFloat = 10
            }
        
            enum PlayAgainButton {
                static let width: CGFloat = 220
                static let height: CGFloat = 60
                static let insetTop: CGFloat = 40
                static let cornerRadius: CGFloat = 20
            }
        
    }
    
}
