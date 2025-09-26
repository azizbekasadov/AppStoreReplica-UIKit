import Foundation

#if canImport(UIKit)
import UIKit

final class LargeCategoryCell: CategoryCell {
    static let cellidA = "\(LargeCategoryCell.self)'"
    
    override func setupViews() {
        appsCollectionView.register(
            LargeAppCell.self,
            forCellWithReuseIdentifier: LargeAppCell.cellidA
        )
        
        super.setupViews()
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 200, height: collectionView.bounds.height - 32)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeAppCell.cellidA, for: indexPath) as! LargeAppCell
        cell.setAppModel(appCategory.app[indexPath.item])
        return cell
    }
}

#endif
