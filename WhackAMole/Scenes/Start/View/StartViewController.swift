//
//  StartViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import UIKit
import SnapKit

final class StartViewController: BaseViewController {
    
    var output: StartViewOutput?
    
    private let headerImageView = UIImageView()
    private let moleImageView = UIImageView()
    private let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @objc
    private func handleStartButton() {
        output?.didTapOnStartButton()
    }
    
    private func setup() {
        setupSuperView()
        setupHeaderImageView()
        setupMoleImageView()
        setupStartButton()
    }
    
    private func setupSuperView() {
        setBackgroundImage(named: "start-background")
    }
    
    private func setupHeaderImageView() {
        view.addSubview(headerImageView)
        
        headerImageView.image = UIImage(named: "header-image")
        headerImageView.contentMode = .scaleAspectFill
        
        headerImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.HeaderImageView.insetTop)
            make.width.equalToSuperview().multipliedBy(Constants.HeaderImageView.multiplierWidth)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupMoleImageView() {
        view.addSubview(moleImageView)
        
        moleImageView.image = UIImage(named: "appearing-large")
        moleImageView.contentMode = .scaleAspectFill
        
        moleImageView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(Constants.MoleImageView.insetTop)
            make.width.height.equalTo(Constants.MoleImageView.size)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        
        startButton.tintColor = .appWhite
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        startButton.backgroundColor = UIColor.startButtonBackground
        startButton.layer.cornerRadius = Constants.StartButton.cornerRadius
        startButton.layer.borderWidth = Constants.StartButton.borderWidth
        startButton.layer.borderColor = UIColor.appWhite?.cgColor
        startButton.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(moleImageView.snp.bottom).offset(Constants.StartButton.insetTop)
            make.height.width.equalTo(Constants.StartButton.size)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - StartViewInput

extension StartViewController: StartViewInput {
    
}

private extension StartViewController {
    
    enum Constants {
        
            enum HeaderImageView {
                static let insetTop: CGFloat = 50
                static let multiplierWidth: CGFloat = 0.5
            }
        
            enum MoleImageView {
                static let size: CGFloat = 120
                static let insetTop: CGFloat = 90
            }
            
            enum StartButton {
                static let insetTop: CGFloat = 90
                static let size: CGFloat = 95
                static let borderWidth: CGFloat = 4
                static let cornerRadius: CGFloat = size / 2
            }
        
    }
    
}
