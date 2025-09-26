import Foundation

#if canImport(UIKit)
import UIKit

class CoreViewController: UIViewController {
    var onPortraitOrientation: (()->Void)?
    var onLandscapeOrientation: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(CoreViewController.didScreenOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func didScreenOrientationChange() {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            onPortraitOrientation?()
        case .landscapeLeft, .landscapeRight:
            onLandscapeOrientation?()
        default:
            break
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class CoreCollectionViewController: UICollectionViewController {
    var onPortraitOrientation: (()->Void)?
    var onLandscapeOrientation: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(CoreCollectionViewController.didScreenOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func didScreenOrientationChange() {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            onPortraitOrientation?()
        case .landscapeLeft, .landscapeRight:
            onLandscapeOrientation?()
        default:
            break
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

#endif
