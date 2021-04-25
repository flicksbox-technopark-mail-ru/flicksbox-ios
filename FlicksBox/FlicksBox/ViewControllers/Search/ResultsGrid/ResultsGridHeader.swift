//
//  ResultsGridHeader.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.04.2021.
//

import UIKit
import Botticelli

final class ResultsGridHeader: UICollectionReusableView {

    let titleLabel: SBLabel = {
        let label = SBLabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    private func configureSubviews() {
        titleLabel.frame = CGRect(
            x: bounds.minX + 20,
            y: bounds.minY,
            width: bounds.width,
            height: bounds.height
        )
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
