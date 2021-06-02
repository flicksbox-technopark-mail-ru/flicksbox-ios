//
//  RecommendationsGridView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 29.03.2021.
//

import UIKit
import Botticelli

protocol RecommendationsGridViewDelegate: AnyObject {
    func didSelectCell(content: ContentInfo)
}

final class RecommendationsGridView: SBView {
    weak var delegate: RecommendationsGridViewDelegate?
    
    private var content: [ContentInfo] = []
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
        collectionView.isUserInteractionEnabled = true
        
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
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(_ content: [ContentInfo]) {
        self.content = content
        self.collectionView.reloadData()
    }
}

extension RecommendationsGridView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension RecommendationsGridView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.25, animations: {
            cell?.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.25, animations: {
                cell?.alpha = 1
            })
        }
        delegate?.didSelectCell(content: content[indexPath.row])
    }
}
