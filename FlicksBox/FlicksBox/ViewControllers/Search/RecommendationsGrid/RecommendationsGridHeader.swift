//
//  RecommendationsGridHeader.swift
//  FlicksBox
//
//  Created by Mac-HOME on 01.04.2021.
//

import UIKit
import Botticelli

final class RecommendationsGridHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    private func configureSubviews() {
        let titleLabel = SBLabel()
        titleLabel.numberOfLines = 1
        titleLabel.text = "Рекомендуемое"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)

        titleLabel.frame = CGRect(
            x: frame.minX + 20,
            y: frame.minY,
            width: frame.width,
            height: frame.height
        )
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
