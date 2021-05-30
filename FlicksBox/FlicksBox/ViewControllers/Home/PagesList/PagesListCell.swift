//
//  PagesListCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 03.05.2021.
//

import UIKit
import Botticelli

struct PreviewPage {
    let title: String
    let font: UIFont
    let size: CGSize // for calculating width of cell
    
    init(_ title: String) {
        self.title = title
        self.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        self.size = (title as NSString).size(withAttributes: fontAttributes)
    }
}

class PagesListCell: UICollectionViewCell {
    var page: PreviewPage? {
        didSet {
            guard let page = page else { return }
            titleLabel.text = page.title
            titleLabel.font = page.font
        }
    }
    
    private lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureView()
        contentView.addSubview(titleLabel)
    }
    
    private func configureView() {
        contentView.backgroundColor = .clear
    }
    
    private func configureSubviews() {
        titleLabel.frame = bounds
        customizeAsUnselected()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeAsSelected() {
        titleLabel.textColor = .white
    }
    
    func customizeAsUnselected() {
        titleLabel.textColor = .lightGray
    }
}
