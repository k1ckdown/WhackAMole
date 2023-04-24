//
//  BaseViewController.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 25.04.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}

extension BaseViewController {
    func setBackgroundImage(named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
