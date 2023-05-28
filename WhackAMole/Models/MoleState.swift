//
//  MoleState.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 30.04.2023.
//

import Foundation

enum StateType: String, CaseIterable {
    case large
    case medium
    case small
}

enum MoleState: Equatable {
    case hit
    case hurt(type: StateType)
    case appearing(type: StateType)
    case disappearing
    
    var description: String {
        switch self {
        case .hit:
            return "hit"
        case .hurt(let type):
            return "hurt-\(type.rawValue)"
        case .appearing(let type):
            return "appearing-\(type.rawValue)"
        case .disappearing:
            return "disappearing"
        }
    }
}
