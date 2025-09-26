import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private(set) var coordinator: AppCoordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        coordinator = AppCoordinator(windowScene)
        coordinator.start()
    }
}
