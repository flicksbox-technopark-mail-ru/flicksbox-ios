//
//  ContentGridView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

final class ContentGridView: SBView {
    private var content: [ContentInfo] = []
    private let sideSpace: CGFloat = 10
    private let cellCountOnRow: CGFloat = 2

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sideSpace
        layout.minimumLineSpacing = sideSpace
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

    func updateData(_ content: [ContentInfo]) {
        self.content = content
        self.collectionView.reloadData()
    }
}

extension ContentGridView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(ContentGridCell.self),
            for: indexPath
        ) as! ContentGridCell

        cell.film = content[indexPath.row]
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spaces = sideSpace * (cellCountOnRow * 2 + 1)
        let width = (bounds.width - spaces) / cellCountOnRow
        let height = width / 16 * 9
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: sideSpace, left: sideSpace * 2, bottom: sideSpace, right: sideSpace * 2)
    }
}

extension ContentGridView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}
