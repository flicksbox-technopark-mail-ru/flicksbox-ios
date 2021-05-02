//
//  ResultsGridView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 28.03.2021.
//

import UIKit
import Botticelli

final class ResultsGridView: SBView {
    private var content: [ContentInfo] = []
    private var actors: [Actor] = []
    private let sectionTitles = ["Фильмы и сериалы", "Актеры"]
    private let lineSpace: CGFloat = 10
    private let cellCountOnRow: CGFloat = 2
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = lineSpace
        layout.minimumLineSpacing = lineSpace
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.register(
            ContentGridCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(ContentGridCell.self)
        )
        collectionView.register(
            ResultsActorGridCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(ResultsActorGridCell.self)
        )
        collectionView.register(
            ResultsGridHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(ResultsGridHeader.self)
        )
        collectionView.register(
            ResultsGridFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: NSStringFromClass(ResultsGridFooter.self)
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
    
    func updateData(content: [ContentInfo], actors: [Actor]) {
        self.content = content
        self.actors = actors
        self.collectionView.reloadData()
    }
}

extension ResultsGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return content.count
        } else {
            return actors.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ContentGridCell.self), for: indexPath) as! ContentGridCell
            cell.film = content[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ResultsActorGridCell.self), for: indexPath) as! ResultsActorGridCell
            cell.actor = actors[indexPath.row]
            return cell
        default:
            fatalError("Unexpected section")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        switch indexPath.section {
        case 0:
            let cellCountOnRow: CGFloat = 2
            let spaces = lineSpace * (cellCountOnRow + 3)
            width = (bounds.width - spaces) / cellCountOnRow
            height = width / 16 * 9
        case 1:
            let cellCountOnRow: CGFloat  = 1
            let spaces = lineSpace * (cellCountOnRow + 3)
            width = (bounds.width - spaces) / cellCountOnRow
            height = 40
        default:
            fatalError("Unexpected section")
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: lineSpace, left: lineSpace * 2, bottom: lineSpace, right: lineSpace * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section) == 0 {
            return CGSize(width: collectionView.frame.width, height: 0)
        }
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: NSStringFromClass(ResultsGridHeader.self),
                for: indexPath
            ) as! ResultsGridHeader
            header.titleLabel.text = sectionTitles[indexPath.section]
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: NSStringFromClass(ResultsGridFooter.self),
                for: indexPath
            ) as! ResultsGridFooter
            return footer
        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension ResultsGridView: UIGestureRecognizerDelegate {}

// Allow collection view multiple gestures recognizers
extension UICollectionView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
