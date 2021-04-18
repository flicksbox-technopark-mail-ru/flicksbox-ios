//
//  HomeFilmCollectionViewCell.swift
//  FlicksBox
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit
import Botticelli

class HomeFilmCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeFilmTableViewCell"
    
    var film: FilmInfo? {
        didSet {
            guard oldValue?.id != film?.id,
                  let urlImage = film?.image else {
                return
            }
            filmNameLabel.text = film?.name
            fimImageView.loadWebP(url: urlImage)
        }
    }
    
    private let cornerRadius: CGFloat = 5
    
    private let filmNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var fimImageView: SBImageView = {
        let imageView = SBImageView()
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = cornerRadius
        
        addSubview(fimImageView)
        addSubview(filmNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fimImageView.frame = bounds
        filmNameLabel.frame = bounds
    }
}
