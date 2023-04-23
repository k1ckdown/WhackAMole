//
//  StartViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import UIKit
import SnapKit

final class StartViewController: UIViewController {
    
    var presenter: StartViewPresenter!
    
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let startButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @objc
    private func startButtonHandle() {
        presenter.didGoToGameScreen()
    }
    
    private func setup() {
        setupBackgroundImageView()
        setupLogoImageView()
        setupStartButton()
    }
    
    private func setupBackgroundImageView() {
        let image = UIImage(named: "back")
        let backgroundImageView = UIImageView(image: image)
        backgroundImageView.contentMode = .scaleAspectFill
        
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        
        let image = UIImage(named: "logo")
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFill
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        startButton.tintColor = .white
        startButton.backgroundColor = UIColor.startButton
        startButton.layer.cornerRadius = 45
        startButton.layer.borderWidth = 4
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.addTarget(self, action: #selector(startButtonHandle), for: .touchUpInside)
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(250)
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.centerX.equalToSuperview()
        }
    }

}

extension StartViewController: StartView {
    
}
