//
//  HomeTableViewCell.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import UIKit

struct FilmInfo {
    let name: String
    let image: String
}

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeFilmsTableViewCell"
    
    var films: [FilmInfo]? {
        didSet {
            guard let _ = films else {
                return
            }
            stopAnimationLoading()
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        collectionView.frame = bounds
        
        activityIndicator.center = contentView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var isAnimation = false
    
    func startAnimationLoading(animated: Bool = false) {
        isAnimation = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.activityIndicator.isHidden = false
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimationLoading(animated: Bool = false) {
        isAnimation = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
}
