//
//  Coordinator.swift
//  WhackAMole
//
//  Created by Ivan Semenov on 23.04.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var rootCoordinator: Coordinator? { get set }
    
    func start()
    func coordinate(to coordintor: Coordinator)
    func didFinish(coordintor: Coordinator)
    func removeChildCoordinators()
}
