//
//  ContentGridCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

class ContentGridCell: UICollectionViewCell {
    static let identifier = "ContentGridCell"
    
    var film: ContentInfo? {
        didSet {
            guard oldValue?.contentId != film?.contentId,
                  let urlImage = film?.image else { return }
            titleLabel.text = film?.name
            poster.loadWebP(url: urlImage)
        }
    }
    
    private let poster: SBImageView = {
        let poster = SBImageView()
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private let titleLabel: SBLabel = {
        let label = SBLabel()
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.4, 1.1]
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureSubviews()
    }
    
    private func configureLayout() {
        backgroundColor = .darkGray
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    private func configureSubviews() {
        poster.frame = contentView.bounds
        contentView.addSubview(poster)
        
        gradientLayer.frame = contentView.frame
        contentView.layer.addSublayer(gradientLayer)
        
        let sideSpace: CGFloat = 10
        let titleHeight: CGFloat = 40
        titleLabel.frame = CGRect(
            x: contentView.bounds.minX + sideSpace,
            y: contentView.bounds.maxY - titleHeight,
            width: contentView.bounds.width - sideSpace * 2,
            height: titleHeight
        )
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
