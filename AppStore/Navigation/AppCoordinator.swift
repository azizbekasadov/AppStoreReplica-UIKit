//
//  AppCoordinator.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

#if canImport(UIKit)
import UIKit

enum ASDestination: String, Identifiable {
    case appInfo
    
    var id: String {
        self.rawValue
    }
}

protocol ASCoordinator {
    func push(to destination: ASDestination)
    func start()
    func pop()
    func popToRoot()
}

final class AppCoordinator: ASCoordinator {
    private var window: UIWindow!
    
    private unowned(unsafe) var navigationController: UINavigationController!
    
    init(_ windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let rootViewController = FeatureAppsViewController(
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func push(to destination: ASDestination) {
        let viewController: UIViewController = {
            switch destination {
            case .appInfo:
                return UIViewController()
            }
        }()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        guard let root = navigationController?.viewControllers.first else {
            fatalError("Unable to find root")
        }
        
        navigationController?.setViewControllers([root], animated: true)
    }
}

#endif
