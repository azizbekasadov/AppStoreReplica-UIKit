import Foundation

#if canImport(UIKit)
import UIKit

final class BannerCell: AppCell {
    static let cellidA = "\(BannerCell.self)'"
    
    override func setupViews() {
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
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v0]|",
                options: [],
                metrics: nil,
                views: ["v0": imageView]
            )
        )
    }
}

#endif
