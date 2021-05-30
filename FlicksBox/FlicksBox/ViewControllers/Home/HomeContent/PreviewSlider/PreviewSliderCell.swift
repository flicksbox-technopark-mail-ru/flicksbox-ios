//
//  PreviewSliderCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 03.05.2021.
//

import UIKit
import Botticelli

class PreviewSliderCell: UICollectionViewCell {
    var content: ContentInfo? {
        didSet {
            guard oldValue?.contentId != content?.contentId,
                  let urlImage = content?.image else { return }
            titleLabel.text = content?.name
            poster.loadWebP(url: urlImage)
            setDescription(content?.short_desc ?? "")
        }
    }
    
    private let poster: SBImageView = {
        let poster = SBImageView()
        poster.backgroundColor = .darkGray
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private let titleLabel: SBLabel = {
        let label = SBLabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let descLabel: SBLabel = {
        let label = SBLabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        addSubview(poster)
        addSubview(titleLabel)
        addSubview(descLabel)
    }
    
    private func configureSubviews() {
        let posterHeight = bounds.width / 16 * 9
        poster.frame = CGRect(x: 0, y: 0, width: bounds.width, height: posterHeight)
        titleLabel.frame = CGRect(x: 0, y: poster.frame.maxY + 15, width: bounds.width, height: 20)
        descLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 5, width: bounds.width, height: 70)
    }
    
    private func setDescription(_ desc: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.5
        
        let attributedString = NSMutableAttributedString(string: desc)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        descLabel.attributedText = attributedString
        descLabel.lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
