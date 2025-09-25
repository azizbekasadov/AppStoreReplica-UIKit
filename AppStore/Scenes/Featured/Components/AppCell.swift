//
//  AppCell.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

#if canImport(UIKit)
import UIKit

final class AppCell: UICollectionViewCell {
    static let cellid = "\(AppCell.self)'"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        #if DEBUG
        imageView.image = UIImage(named: "frozen")
        #endif
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        #if DEBUG
        label.text = "Hello World!"
        #endif
        label.font = UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.minimumScaleFactor  = 0.8
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        #if DEBUG
        label.text = "Hello World!"
        #endif
        label.font = UIFont.systemFont(
            ofSize: 13,
            weight: .medium
        )
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor  = 0.8
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        #if DEBUG
        label.text = "45.- CHF"
        #endif
        label.font = UIFont.systemFont(
            ofSize: 13,
            weight: .medium
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor  = 0.8
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("Use Code only")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0": imageView]
            )
        )
        contentView.addConstraints(
            [
                NSLayoutConstraint(
                    item: imageView,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: imageView,
                    attribute: .width,
                    multiplier: 1.0,
                    constant: 0
                )
            ]
        )
        
        contentView.addSubview(titleLabel)
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0": titleLabel]
            )
        )
        
        contentView.addSubview(subTitleLabel)
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0": subTitleLabel]
            )
        )
        
        contentView.addSubview(priceLabel)
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0": priceLabel]
            )
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v0][v1][v2][v3]|",
                options: [],
                metrics: nil,
                views: [
                    "v0": imageView,
                    "v1":titleLabel,
                    "v2":subTitleLabel,
                    "v3":priceLabel
                ]
            )
        )
    }
}

#endif
