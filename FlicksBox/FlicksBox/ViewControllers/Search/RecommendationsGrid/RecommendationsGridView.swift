//
//  RecommendationsGridView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 29.03.2021.
//

import UIKit
import Botticelli

final class RecommendationsGridView: SBView {
    private var content: [FilmInfo] = []
    private let lineSpace: CGFloat = 10
    private let cellCountOnRow: CGFloat = 1
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 7
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.register(
            RecommendationsGridCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(RecommendationsGridCell.self)
        )
        collectionView.register(
            RecommendationsGridHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(RecommendationsGridHeader.self)
        )
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    private func configureSubviews() {
        collectionView.frame = bounds
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(_ content: [FilmInfo]) {
        self.content = content
        self.collectionView.reloadData()
    }
}

extension RecommendationsGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(RecommendationsGridCell.self),
            for: indexPath
        ) as! RecommendationsGridCell
        
        cell.content = content[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spaces = lineSpace * (cellCountOnRow + 3)
        let width = (bounds.width - spaces) / cellCountOnRow
        return CGSize(width: width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: lineSpace, left: lineSpace * 2, bottom: lineSpace, right: lineSpace * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: NSStringFromClass(RecommendationsGridHeader.self),
                for: indexPath
            ) as! RecommendationsGridHeader
            
        default:
            fatalError("Unexpected element kind")
        }
    }
}
