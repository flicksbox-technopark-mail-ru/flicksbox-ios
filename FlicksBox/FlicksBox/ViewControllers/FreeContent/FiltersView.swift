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
    var filterObserver: ((Filter?) -> ())? {
        didSet {
            guard let obsever = filterObserver else { return }
            genreButton.filterObserver = obsever
            yearButton.filterObserver = obsever
            countryButton.filterObserver = obsever
        }
    }
    
    var genres: [Genre]? {
        didSet {
            guard var genres = genres else { return }
            genres.insert(Genre(name: "Все жанры"), at: 0)
            genreButton.setData(data: genres)
        }
    }
    
    var countries: [Country]? {
        didSet {
            guard var countries = countries else { return }
            countries.insert(Country(name: "Все страны"), at: 0)
            countryButton.setData(data: countries)
        }
    }
    
    var years: [Year]? {
        didSet {
            guard var years = years else { return }
            years.insert(Year(name: "Все года"), at: 0)
            yearButton.setData(data: years)
        }
    }
    
    var genreButton: FilterButton!
    var yearButton: FilterButton!
    var countryButton: FilterButton!
    
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
        genreButton = FilterButton(frame: gbFrame, title: "Все жанры", filtersListView)
        
        let ybFrame = CGRect(
            x: genreButton.frame.maxX + interitemSpacing,
            y: bounds.minY,
            width: buttonWidth,
            height: bounds.height
        )
        yearButton = FilterButton(frame: ybFrame, title: "Все года", filtersListView)
        
        let cbFrame = CGRect(
            x: yearButton.frame.maxX + interitemSpacing,
            y: bounds.minY,
            width: buttonWidth,
            height: bounds.height
        )
        countryButton = FilterButton(frame: cbFrame, title: "Все страны", filtersListView)
        
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
    var selectedRow: Int = 0
    var filterObserver: ((Filter?) -> ())?
    var filtersListPresented: Bool = false
    
    var data: [Filter] = [] {
        didSet {
            if filtersListPresented {
                filtersListView.setData(data, selectedRow)
            }
        }
    }
    
    init(frame: CGRect, title: String, _ filtersListView: FiltersListView) {
        super.init(frame: frame)
        self.filtersListView = filtersListView
        configureView(title)
        configureImageView()
    }
    
    func setData(data: [Filter]) {
        self.data = data
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
        filtersListPresented = true
    }
    
    private func setupSelectionObserver() {
        filtersListView.selectionObserver = { [weak self] (selectedRow) in
            self?.filtersListPresented = false
            self?.selectedRow = selectedRow
            self?.setTitle(self?.data[selectedRow].name, for: .normal)
            self?.filterObserver?(self?.data[selectedRow])
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
