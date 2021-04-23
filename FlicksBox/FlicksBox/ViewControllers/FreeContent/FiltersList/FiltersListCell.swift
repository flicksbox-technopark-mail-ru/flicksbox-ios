//
//  FiltersListCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 07.04.2021.
//

import UIKit
import Botticelli

class FiltersListCell: UICollectionViewCell {
    lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        customizeAsUnselected()
        
        titleLabel.text = "США"
    }
    
    private func configureSubviews() {
        let sideSpacing: CGFloat = 80
        titleLabel.frame = CGRect(
            x: contentView.frame.minX + sideSpacing,
            y: contentView.frame.minY,
            width: contentView.frame.width - sideSpacing * 2,
            height: contentView.frame.height
        )
        contentView.addSubview(titleLabel)
    }
    
    func customizeAsSelected() {
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .white
    }
    
    func customizeAsUnselected() {
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
