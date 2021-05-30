//
//  PreviewSliderView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.05.2021.
//

import UIKit
import Botticelli

class PreviewSliderView: SBView {
    private let fakeCellsCount = 40
    private var content: [ContentInfo] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(
            PreviewSliderCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(PreviewSliderCell.self)
        )
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        addSubview(collectionView)
    }
    
    private func configureSubviews() {
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(_ content: [ContentInfo]) {
        self.content = content
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: fakeCellsCount / 2, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension PreviewSliderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fakeCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(PreviewSliderCell.self),
            for: indexPath
        ) as! PreviewSliderCell
        
        guard content.count > 0 else { return cell }
        
        let index = indexPath.row % content.count
        cell.content = content[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width - 40, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let translation = collectionView.panGestureRecognizer.translation(in: scrollView.superview)
        
        var indexes = self.collectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        
        let cell = self.collectionView.cellForItem(at: index)!
        let position = self.collectionView.contentOffset.x - cell.frame.origin.x
        
        if translation.x < 0 && position > cell.frame.size.width / 5 {
            // to right swipe
            index.row = index.row + 1
        }
        if translation.x > 0 && position > cell.frame.size.width * 4 / 5 {
            // to left swipe
            index.row = index.row + 1
        }
        self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}
