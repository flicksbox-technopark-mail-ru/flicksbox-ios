//
//  FreeContentViewController.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

final class FreeContentViewController: SBViewController {
    private let contentModel = FreeContentModel()
    private let filtersModel = FiltersModel()
    
    private lazy var filtersListView: FiltersListView = {
        FiltersListView(frame: view.bounds)
    }()
    
    private lazy var filtersView: FiltersView = {
        let viewFrame = CGRect(
            x: view.bounds.minX,
            y: view.bounds.minY + 100,
            width: view.bounds.width,
            height: 40
        )
        return FiltersView(frame: viewFrame, filtersListView)
    }()
    
    private lazy var contentGridView: ContentGridView = {
        let viewFrame = CGRect(
            x: view.bounds.minX,
            y: filtersView.frame.maxY,
            width: view.bounds.width,
            height: view.bounds.height - filtersView.frame.maxY
        )
        return ContentGridView(frame: viewFrame)
    }()
    
    private lazy var emptyResultView: ContentEmptyResultView = {
        let sideSpace: CGFloat = 20
        let viewFrame = CGRect(
            x: view.bounds.minX + sideSpace,
            y: view.bounds.minY,
            width: view.bounds.width - sideSpace * 2,
            height: view.bounds.height - 300
        )
        return ContentEmptyResultView(frame: viewFrame)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        loadContent()
        loadFilters()
        setupFilterObserver()
    }
    
    private func configureSubviews() {
        view.addSubview(emptyResultView)
        view.addSubview(contentGridView)
        view.addSubview(filtersView)
        view.addSubview(filtersListView)
        filtersListView.isHidden = true
        showContentGridView()
    }
    
    private func loadContent() {
        contentModel.loadData() { [weak self] films in
            DispatchQueue.main.async {
                if films.count == 0 {
                    self?.showEmptyResultView()
                } else {
                    self?.showContentGridView()
                    self?.contentGridView.updateData(films)
                    if self?.filtersView.years == nil {
                        self?.loadYearFilters(films)
                    }
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }
    
    private func loadYearFilters(_ films: [FilmInfo]) {
        var yearsVal = films.map {
            $0.year
        }
        yearsVal = yearsVal.uniqued().sorted { $0 > $1 }
        
        let years = yearsVal.map {
            Year($0)
        }
        self.filtersView.years = years
    }
    
    private func loadFilters() {
        filtersModel.loadGenres() { [weak self] genres in
            DispatchQueue.main.async {
                self?.filtersView.genres = genres
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
        
        filtersModel.loadCountries() { [weak self] countries in
            DispatchQueue.main.async {
                self?.filtersView.countries = countries
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }
    
    private func setupFilterObserver() {
        filtersView.filterObserver = { [weak self] (filter) in
            switch filter {
            case is Genre:
                self?.contentModel.setGenreFilter(filter as? Genre)
            case is Country:
                self?.contentModel.setCountryFilter(filter as? Country)
            case is Year:
                self?.contentModel.setYearFilter(filter as? Year)
            default:
                fatalError("Unexpected filter type")
            }
            self?.loadContent()
        }
    }
    
    private func showEmptyResultView() {
        emptyResultView.isHidden = false
        contentGridView.isHidden = true
    }
    
    private func showContentGridView() {
        emptyResultView.isHidden = true
        contentGridView.isHidden = false
    }
}

// TODO delete
extension FreeContentViewController: MainOutput {
    func configureTabItem() {
        self.tabBarItem.title = "Поиск"
        self.tabBarItem.image = SBIcon.search // TODO: wtf?
    }
}

// Move to where?
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
