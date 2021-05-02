//
//  RecommendationsGridCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 29.03.2021.
//

import UIKit
import Botticelli

class RecommendationsGridCell: UICollectionViewCell {
    var content: ContentInfo? {
        didSet {
            guard oldValue?.contentId != content?.contentId,
                  let urlImage = content?.image else { return }
            titleLabel.text = content?.name
            poster.loadWebP(url: urlImage)
        }
    }
    
    let poster: SBImageView = {
        let poster = SBImageView()
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.backgroundColor = .darkGray
        return poster
    }()
    
    let playButton: SBButton = {
        let button = SBButton(type: .custom)
        let image = UIImage(named: "play.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        return button
    }()
    
    lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.baselineAdjustment = .alignCenters
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
    }
    private func configureView() {
        backgroundColor = .clear
    }
    
    private func configureSubviews() {
        let sideSpace: CGFloat = 10
        
        poster.frame = CGRect(
            x: contentView.bounds.minX,
            y: contentView.bounds.minY,
            width: contentView.bounds.height / 9 * 16,
            height: contentView.bounds.height
        )
        contentView.addSubview(poster)
        
        let buttonSize: CGFloat = 40
        playButton.frame = CGRect(
            x: contentView.bounds.maxX - buttonSize - sideSpace,
            y: contentView.bounds.minY + buttonSize / 2,
            width: buttonSize,
            height: buttonSize
        )
        contentView.addSubview(playButton)
        
        titleLabel.frame = CGRect(
            x: poster.frame.maxX + sideSpace,
            y: contentView.frame.minY,
            width: contentView.frame.width - poster.bounds.width - buttonSize - sideSpace * 3,
            height: contentView.frame.height
        )
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
