//
//  CategoryCell.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

#if canImport(UIKit)
import UIKit

final class CategoryCell: UICollectionViewCell {
    static let cellid = "\(CategoryCell.self)'"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor  = 0.8
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var appsCollectionView: UICollectionView = {
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
        cv.register(AppCell.self, forCellWithReuseIdentifier: AppCell.cellid)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var dividerLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    
    private var appCategory: AppCategory!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("Use Code only")
    }
    
    func setAppCategory(_ appCategory: AppCategory) {
        self.appCategory = appCategory
        
        titleLabel.text = appCategory.name
        appsCollectionView.reloadData()
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(appsCollectionView)
        contentView.addSubview(dividerLine)
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-14-[v0]-14-|",
                options: [],
                metrics: nil,
                views: ["v0":titleLabel]
            )
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0":appsCollectionView]
            )
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0":dividerLine]
            )
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v0(30)]-3-[v1]-10-[v2(0.5)]|",
                options: [],
                metrics: nil,
                views: [
                    "v0":titleLabel,
                    "v1":appsCollectionView,
                    "v2":dividerLine
                ]
            )
        )
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: min(100.0, collectionView.bounds.width * 0.34),
            height: collectionView.bounds.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return appCategory.app.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCell.cellid, for: indexPath) as! AppCell
        cell.setAppModel(appCategory.app[indexPath.item])
        return cell
    }
}

#endif
