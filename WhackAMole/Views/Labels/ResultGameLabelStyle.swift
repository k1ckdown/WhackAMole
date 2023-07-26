//
//  ResultGameLabelStyle.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 31.05.2023.
//

import UIKit

enum ResultGameLabelStyle {
    case title, score
    
    var font: UIFont {
        switch self {
        case .title:
            return .resultTitle
        case .score:
            return .resultScore
        }
    }
}
