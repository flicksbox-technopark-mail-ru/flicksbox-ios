//
//  PagesListView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.05.2021.
//

import UIKit
import Botticelli

class PagesListView: SBView {
    private var selectionObserver: ((Int) -> ())?
    private var pages: [PreviewPage]!
    private var selectedPage: Int = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isPrefetchingEnabled = false
        
        collectionView.register(
            PagesListCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(PagesListCell.self)
        )
        return collectionView
    }()
    
    init(frame: CGRect, pages: [Page], observer: ((Int) -> ())?) {
        super.init(frame: frame)
        self.pages = pages.map {
            .init($0.name)
        }
        self.selectionObserver = observer
        configureSubviews()
        addSubview(collectionView)
    }
    
    private func configureSubviews() {
        collectionView.frame = bounds
    }
    
    func updateData(pages: [Page]) {
        self.pages = pages.map {
            .init($0.name)
        }
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PagesListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // problem with correct resizeing on reloadData
        // https://stackoverflow.com/questions/47337873/uicollectionview-cells-resize-incorrectly-on-reloaddata
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PagesListCell.self), for: indexPath) as! PagesListCell
        cell.contentView.frame = cell.bounds
        cell.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return CGSize(width: pages[indexPath.row].size.width, height: bounds.height)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PagesListCell.self), for: indexPath) as! PagesListCell
        cell.page = pages[indexPath.row]
        if indexPath.row == selectedPage {
            cell.customizeAsSelected()
        } else {
            cell.customizeAsUnselected()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        unselectAllCells()
        if let cell = collectionView.cellForItem(at: indexPath) as? PagesListCell {
            selectedPage = indexPath.row
            cell.customizeAsSelected()
            collectionView.scrollToItem(at: IndexPath(row: selectedPage, section: 0), at: .centeredHorizontally, animated: true)
            selectionObserver?(selectedPage)
        }
    }
    
    private func unselectAllCells() {
        for cell in self.collectionView.visibleCells as! [PagesListCell] {
            cell.customizeAsUnselected()
        }
    }
}
