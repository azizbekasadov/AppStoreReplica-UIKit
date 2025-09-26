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
    func push(to destination: ASDestination, animated: Bool)
    func start()
    @discardableResult
    func pop(animated: Bool) -> UIViewController?
    func popToRoot(animated: Bool)
}

final class AppCoordinator: ASCoordinator {
    private var window: UIWindow!
    
    private(set) weak var navigationController: UINavigationController?
    
    init(_ windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        let rootViewController = FeatureAppsViewController(
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        self.navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func push(to destination: ASDestination, animated: Bool = true) {
        let viewController: UIViewController!
        
        switch destination {
        case .appInfo:
            viewController = UIViewController()
        }
        
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    func pop(animated: Bool = true) -> UIViewController? {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        guard let root = navigationController?.viewControllers.first else {
            fatalError("Unable to find root")
        }
        
        navigationController?.setViewControllers([root], animated: animated)
    }
    
    deinit {
        self.navigationController = nil
        self.window = nil
    }
}

#endif
