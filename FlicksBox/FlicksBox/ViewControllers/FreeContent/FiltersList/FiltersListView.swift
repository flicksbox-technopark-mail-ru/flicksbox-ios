//
//  FiltersList.swift
//  FlicksBox
//
//  Created by Mac-HOME on 07.04.2021.
//

import UIKit
import Botticelli

final class FiltersListView: SBView {
    var data: [Filter] = []
    var selectedRow: Int = 0
    var selectionObserver: ((Int) -> Void)?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 7
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear

        collectionView.register(
            FiltersListCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(FiltersListCell.self)
        )
        collectionView.register(
            FiltersListFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: NSStringFromClass(FiltersListFooter.self)
        )
        return collectionView
    }()

    lazy var cancelButton: SBButton = {
        let button = SBButton()
        let image = UIImage(named: "cancel.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.imageView?.backgroundColor = .customBlack
        button.imageView?.layer.cornerRadius = 30 // TODO need another icon
        button.addTarget(self, action: #selector(self.hideView), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubviews()
    }

    func setData(_ data: [Filter], _ selectedRow: Int) {
        self.data = data
        self.selectedRow = selectedRow
        collectionView.reloadData()
        collectionView.scrollToItem(
            at: IndexPath(row: selectedRow, section: 0),
            at: .centeredVertically,
            animated: false
        )
    }

    private func configureView() {
        backgroundColor = .clear
    }

    private func configureSubviews() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)

        collectionView.frame = bounds
        addSubview(collectionView)

        let darkeringLayer = CAGradientLayer()
        darkeringLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        darkeringLayer.locations = [0.7, 1]
        darkeringLayer.frame = bounds
        layer.addSublayer(darkeringLayer)

        let cbSize: CGFloat = 60
        cancelButton.frame = CGRect(
            x: bounds.midX - cbSize / 2,
            y: bounds.maxY - 180,
            width: cbSize,
            height: cbSize
        )
        addSubview(cancelButton)
    }

    @objc private func hideView() {
        self.fadeOut()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FiltersListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(FiltersListCell.self),
            for: indexPath
        ) as! FiltersListCell

        cell.titleLabel.text = data[indexPath.row].name
        if indexPath.row == selectedRow {
            cell.customizeAsSelected()
        } else {
            cell.customizeAsUnselected()
        }
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: bounds.width, height: 50)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        unselectAllCells()
        if let cell = collectionView.cellForItem(at: indexPath) as? FiltersListCell {
            cell.customizeAsSelected()
            selectionObserver?(indexPath.row)

            _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (_) in
                self.isHidden = true
            }
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: NSStringFromClass(FiltersListFooter.self),
                for: indexPath
            ) as! FiltersListFooter
            return footer
        default:
            fatalError("Unexpected element kind")
        }
    }

    private func unselectAllCells() {
        for cell in collectionView.visibleCells as! [FiltersListCell] {
            cell.customizeAsUnselected()
        }
    }
}
