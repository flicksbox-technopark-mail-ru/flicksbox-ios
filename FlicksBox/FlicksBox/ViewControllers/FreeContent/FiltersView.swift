//
//  FiltersView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

final class FiltersView: SBView {
    var filtersListView: FiltersListView!
    var filtersObserver: ((Int) -> ())?
    
    let genres = ["Все жанры", "Комедия", "Драма", "Мультфильмы", "Фэнтези"]
    let years = ["Все года", "2010", "2011", "2012", "2013"]
    let countries = ["Все страны", "США", "Россия", "Великобритания", "Латвия"]
    
    init(frame: CGRect, _ filtersListView: FiltersListView) {
        super.init(frame: frame)
        self.filtersListView = filtersListView
        configureSubviews()
    }
    
    private func configureSubviews() {
        let interitemSpacing: CGFloat = 10
        let sideSpacing: CGFloat = bounds.width / 20
        let buttonWidth: CGFloat = (bounds.width - sideSpacing * 2 - interitemSpacing * 2) / 3
        
        let gbFrame = CGRect(
            x: bounds.minX + sideSpacing,
            y: bounds.minY,
            width: buttonWidth,
            height: bounds.height
        )
        let genreButton = FilterButton(frame: gbFrame, title: "Все жанры", data: genres, filtersListView: filtersListView)
        
        let ybFrame = CGRect(
            x: genreButton.frame.maxX + interitemSpacing,
            y: bounds.minY,
            width: buttonWidth,
            height: bounds.height
        )
        let yearButton = FilterButton(frame: ybFrame, title: "Все года", data: years, filtersListView: filtersListView)
        
        let cbFrame = CGRect(
            x: yearButton.frame.maxX + interitemSpacing,
            y: bounds.minY,
            width: buttonWidth,
            height: bounds.height
        )
        let countryButton = FilterButton(frame: cbFrame, title: "Все страны", data: countries, filtersListView: filtersListView)
        
        addSubview(genreButton)
        addSubview(yearButton)
        addSubview(countryButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FilterButton: SBButton {
    var filtersListView: FiltersListView!
    var data: [String]!
    var selectedRow: Int = 0
    
    init(frame: CGRect, title: String, data: [String], filtersListView: FiltersListView) {
        super.init(frame: frame)
        self.filtersListView = filtersListView
        self.data = data
        configureView(title)
        configureImageView()
    }
    
    private func configureView(_ title: String) {
        setTitle(title, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.baselineAdjustment = .alignCenters
        titleLabel?.lineBreakMode = .byTruncatingTail
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel?.adjustsFontSizeToFitWidth = true
        addTarget(self, action: #selector(self.showFiltersList), for: .touchUpInside)
    }
    
    private func configureImageView() {
        let image = UIImage(named: "sort_down.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        
        // move image to right side
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    @objc private func showFiltersList() {
        filtersListView.setData(data, selectedRow)
        setupSelectionObserver()
        filtersListView.fadeIn()
    }
    
    private func setupSelectionObserver() {
        filtersListView.selectionObserver = { [weak self] (selectedRow) in
            self?.selectedRow = selectedRow
            self?.setTitle(self?.data[selectedRow], for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// TODO move to SBView
extension SBView {
    func fadeIn(_ duration: TimeInterval? = 0.1, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(
            withDuration: duration!,
            animations: { self.alpha = 1 },
            completion: { (value: Bool) in
                if let complete = onCompletion { complete() }
            }
        )
    }

    func fadeOut(_ duration: TimeInterval? = 0.1, onCompletion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration!,
            animations: { self.alpha = 0 },
            completion: { (value: Bool) in
                self.isHidden = true
                if let complete = onCompletion { complete() }
            }
        )
    }
}
