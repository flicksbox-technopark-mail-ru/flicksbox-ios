//
//  ResultActorGridCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.04.2021.
//

import UIKit
import Botticelli

class ResultsActorGridCell: UICollectionViewCell {

    let titleLabel: SBLabel = {
        let label = SBLabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureView()
        
        titleLabel.text = "Орландо Блум"
    }
    
    private func configureView() {
        contentView.backgroundColor = .clear
    }
    
    private func configureSubviews() {
        titleLabel.frame = CGRect(
            x: contentView.bounds.minX,
            y: contentView.bounds.minY,
            width: contentView.bounds.width,
            height: contentView.bounds.height
        )
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
