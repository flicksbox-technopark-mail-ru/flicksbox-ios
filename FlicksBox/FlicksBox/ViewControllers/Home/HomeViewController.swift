//
//  HomeViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import UIKit
import Botticelli

final class HomeViewController: SBViewController {
    private let model = HomeModel()
    
    private let pagesListHeight: CGFloat = 60
    private lazy var pagesListView: PagesListView = {
        let pagesFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: pagesListHeight)
        let pageSelectionObserver: ((Int) -> ())? = { [weak self] (selectedPage) in
            self?.hideAllPages()
            let pageType = Page.PageType(rawValue: selectedPage)
            switch pageType {
            case .Main:
                self?.mainPageVC.view.isHidden = false
            case .Movies:
                self?.moviesPageVC.view.isHidden = false
            case .TVShows:
                self?.tvshowsPageVC.view.isHidden = false
            default:
                fatalError("Unexpected page type")
            }
        }
        return PagesListView(frame: pagesFrame, pages: model.pages, observer: pageSelectionObserver)
    }()
    
    private lazy var pageFrame = CGRect(
        x: 0,
        y: pagesListView.frame.maxY,
        width: view.bounds.width,
        height: view.bounds.height - pagesListHeight
    )
    private lazy var mainPageVC = HomeContentViewController(model: model.getPageModel(page: .Main))
    private lazy var moviesPageVC = HomeContentViewController(model: model.getPageModel(page: .Movies))
    private lazy var tvshowsPageVC = HomeContentViewController(model: model.getPageModel(page: .TVShows))
//    private lazy var myListVC = HomeContentViewController(model: model.getPageModel(page: .MyList))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pagesListView)
        add(tvshowsPageVC, frame: pageFrame)
        add(moviesPageVC, frame: pageFrame)
        add(mainPageVC, frame: pageFrame)
    }
    
    private func hideAllPages() {
        mainPageVC.view.isHidden = true
        moviesPageVC.view.isHidden = true
        tvshowsPageVC.view.isHidden = true
    }
}

extension HomeViewController: MainOutput {
    func configureTabItem() {
        self.title = "FlicksBox"
        self.tabBarItem.image = SBIcon.house
    }
}

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
