#if canImport(UIKit)
import UIKit

final class FeatureAppsViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCells()
        setupViews()
    }
    
    private func setupViews() {
        collectionView.backgroundColor = UIColor.white
    }
    
    private func setupCells() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellid)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        NSLog("@%@", #function)
    }
}

extension FeatureAppsViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.cellid,
            for: indexPath
        ) as! CategoryCell
        
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 3
    }
}

#endif

