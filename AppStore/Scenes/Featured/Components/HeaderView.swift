import Foundation

#if canImport(UIKit)
import UIKit

final class HeaderView: UICollectionReusableView {
    static let cellid: String = "\(HeaderView.self)"
    
    private(set) lazy var appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private(set) var appCategory: AppCategory?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("Use Code only")
    }
    
    func setupViews() {
        appsCollectionView.register(
            BannerCell.self,
            forCellWithReuseIdentifier: BannerCell.cellidA
        )
        
        addSubview(appsCollectionView)
        
        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                metrics: nil,
                views: ["v0":appsCollectionView]
            )
        )
        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v0]|",
                metrics: nil,
                views: ["v0":appsCollectionView]
            )
        )
    }
    
    func setAppCategory(_ appCategory: AppCategory) {
        self.appCategory = appCategory
        
        appsCollectionView.reloadData()
    }
}

extension HeaderView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return appCategory?.app.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.cellidA, for: indexPath) as! BannerCell
        
        if let model = appCategory?.app[indexPath.item] {
            cell.setAppModel(model)
        }
        
        return cell
    }
}

extension HeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width * 0.5 + 50,
            height: collectionView.bounds.height
        )
    }
}

#endif
