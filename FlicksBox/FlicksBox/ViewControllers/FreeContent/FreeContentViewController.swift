//
//  FreeContentViewController.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

final class FreeContentViewController: SBViewController {
    let model = FreeContentModel()
    
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
        model.loadData() { [weak self] films in
            DispatchQueue.main.async {
                if films.count == 0 {
                    self?.showEmptyResultView()
                } else {
                    self?.contentGridView.updateData(films)
                }
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
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
