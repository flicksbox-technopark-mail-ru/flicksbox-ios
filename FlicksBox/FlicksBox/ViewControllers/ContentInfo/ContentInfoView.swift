//
//  ContentInfoView.swift
//  FlicksBox
//
//  Created by sn.alekseev on 02.06.2021.
//

import UIKit

final class ContentInfoView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    var name: String? {
        get {
            nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var descriptionText: String? {
        get {
            descriptionLabel.text
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    var descriptionColor: UIColor {
        get {
            descriptionLabel.textColor
        }
        set {
            descriptionLabel.textColor = newValue
        }
    }
    
    convenience init(name: String) {
        self.init(frame: .zero)
        nameLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let descriptionFrame = descriptionLabel.sizeThatFits(CGSize(width: bounds.width * 2 / 3, height: bounds.height))
        descriptionLabel.frame = CGRect(origin: CGPoint(x: bounds.maxX - descriptionFrame.width, y: bounds.minY), size: CGSize(width: descriptionFrame.width, height: bounds.height))
        
        nameLabel.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width - descriptionLabel.frame.width, height: bounds.height)
    }
}
