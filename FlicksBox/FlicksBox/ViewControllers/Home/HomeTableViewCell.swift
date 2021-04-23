//
//  HomeTableViewCell.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeFilmsTableViewCell"
    
    var films: [FilmInfo]? {
        didSet {
            guard let _ = films else {
                return
            }
            stopAnimationLoading()
            loadFilms()
        }
    }
    
    var navigationController: UINavigationController?
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ContentGridCell.self, forCellWithReuseIdentifier: ContentGridCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        return indicator
    }()
    
    private var isAnimationLoading = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        activityIndicator.center = contentView.center
    }
    
    func startAnimationLoading(animated: Bool = false) {
        isAnimationLoading = true
        UIView.animate(withDuration: animated ? 0.3 : 0) { [weak self] in
            self?.activityIndicator.isHidden = false
            self?.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimationLoading(animated: Bool = false) {
        isAnimationLoading = false
        UIView.animate(withDuration: animated ? 0.3 : 0) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func loadFilms() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )
}

extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filmInfo = films?[indexPath.row] else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.25, animations: {
            cell?.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.25, animations: {
                cell?.alpha = 1
            })
        }

        let viewController = FactoryViewControllers.createFilmInfo(info: filmInfo)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let films = films else {
            return 0
        }
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentGridCell.identifier, for: indexPath)
        guard let cell = reusableCell as? ContentGridCell,
              let films = films else {
            return reusableCell
        }
        cell.film = films[indexPath.row]
        return cell
    }
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = frame.height - 10
        return CGSize(width: side * 1.75, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
}
