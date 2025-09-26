import Foundation

#if canImport(UIKit)

import UIKit

@MainActor
protocol FeatureAppsCellProvider {
    associatedtype T: UICollectionViewCell
    
    func fetchCellType(
        for indexPath: NSIndexPath,
        of type: T.Type
    ) async throws -> T
}

@MainActor
final class FeatureAppsCellProviderImplementation {
    
}

#endif
