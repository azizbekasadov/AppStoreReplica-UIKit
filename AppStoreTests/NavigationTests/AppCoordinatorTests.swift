//
//  AppCoordinatorTests.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import UIKit
import XCTest

@testable import AppStore

@MainActor
final class AppCoordinatorTests: XCTestCase {

    // asked GPT to help me with this
    private func currentWindowScene(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> UIWindowScene {
        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first
        else {
            XCTFail("No active UIWindowScene found. Ensure tests run with an iOS test host.", file: file, line: line)
            fatalError()
        }
        return scene
    }

    // asked GPT to help me with this
    private func keyWindow(
        in scene: UIWindowScene,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> UIWindow {
        guard let window = scene.windows.first(
            where: { $0.isKeyWindow
            }) ?? scene.windows.first else {
            
            XCTFail("No window found in UIWindowScene.", file: file, line: line)
            fatalError()
        }
        return window
    }

    // MARK: - Tests

    func test_start_setsRootToNavigationControllerWithFeatureApps() async {
        // Given
        let scene = currentWindowScene()
        let coordinator = AppCoordinator(scene)

        // When
        coordinator.start()

        // Then
        let window = keyWindow(in: scene)
        guard let nav = window.rootViewController as? UINavigationController else {
            return XCTFail("Root VC is not a UINavigationController")
        }
        XCTAssertTrue(nav.viewControllers.first is FeatureAppsViewController,
                      "Root navigation stack should start with FeatureAppsViewController")
    }

    func test_push_appInfo_pushesViewController() async {
        // Given
        let scene = currentWindowScene()
        let coordinator = AppCoordinator(scene)
        coordinator.start()

        let window = keyWindow(in: scene)
        guard let nav = window.rootViewController as? UINavigationController else {
            return XCTFail("Root VC is not a UINavigationController")
        }
        let initialCount = nav.viewControllers.count

        // When
        coordinator.push(to: .appInfo)

        // Then
        XCTAssertEqual(nav.viewControllers.count, initialCount + 1,
                       "push(to:) should push a new view controller")
        XCTAssertTrue(nav.topViewController != nil,
                      "For .appInfo the pushed VC is a plain UIViewController in current implementation")
    }

    func test_pop_popsTopViewController() async {
        // Given
        let scene = currentWindowScene()
        let coordinator = AppCoordinator(scene)
        coordinator.start()

        coordinator.push(to: .appInfo)
        let countAfterPush = coordinator.navigationController?.viewControllers.count ?? 0
        XCTAssertGreaterThan(countAfterPush, 1, "Precondition: stack should have at least two VCs after push")

        // When
        coordinator.pop(animated: false)

        // Then
        let countAfterPop = coordinator.navigationController?.viewControllers.count ?? 0
        XCTAssertEqual(countAfterPop, countAfterPush - 1,
                       "pop() should remove the top view controller")
    }

    func test_popToRoot_setsStackToSingleRoot() async {
        // Given
        let scene = currentWindowScene()
        let coordinator = AppCoordinator(scene)
        coordinator.start()
        coordinator.push(to: .appInfo)
        coordinator.push(to: .appInfo)
        
        let countAfterPush = coordinator.navigationController?.viewControllers.count ?? 0
        
        XCTAssertGreaterThan(countAfterPush, 1, "Precondition: need multiple VCs before popToRoot")

        // When
        coordinator.popToRoot(animated: false)

        // Then
        let countAfterPopToRoot = coordinator.navigationController?.viewControllers.count ?? 0
        
        XCTAssertEqual(countAfterPopToRoot, 1, "popToRoot() should leave only the root VC")
        XCTAssertTrue(coordinator.navigationController?.viewControllers.first is FeatureAppsViewController,
                      "Root should remain FeatureAppsViewController")
    }
}
