//
//  HomeTableViewHeader.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.05.2021.
//

import UIKit
import Botticelli

class HomeTableViewHeader: SBView {
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
    lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    private func configureSubviews() {
        let sideSpacing: CGFloat = 20
        let height: CGFloat = 32
        titleLabel.frame = CGRect.init(
            x: sideSpacing,
            y: bounds.maxY - height,
            width: bounds.width - sideSpacing * 2,
            height: bounds.height - height
        )
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
