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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("Use Code only")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .red
    }
}

#endif
