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
    private var myListAdded: Bool = false
    
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
            case .MyList:
                self?.myListVC.loadMyListData()
                self?.myListVC.view.isHidden = false
            default:
                fatalError("Unexpected page type")
            }
        }
        return PagesListView(frame: pagesFrame, pages: model.activePages, observer: pageSelectionObserver)
    }()
    
    private lazy var pageFrame = CGRect(
        x: 0,
        y: pagesListView.frame.maxY,
        width: view.bounds.width,
        height: view.bounds.height - pagesListHeight
    )
    private lazy var mainPageVC = HomeContentViewController(model: model.getPageModel(page: .Main) as! PageModel)
    private lazy var moviesPageVC = HomeContentViewController(model: model.getPageModel(page: .Movies) as! PageModel)
    private lazy var tvshowsPageVC = HomeContentViewController(model: model.getPageModel(page: .TVShows) as! PageModel)
    private lazy var myListVC = MyListViewController(model: model.getPageModel(page: .MyList) as! MyListModel)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if myListVC.view.isHidden == false {
            myListVC.loadMyListData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pagesListView.updateData(pages: model.activePages)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pagesListView)
        add(myListVC, frame: pageFrame)
        add(tvshowsPageVC, frame: pageFrame)
        add(moviesPageVC, frame: pageFrame)
        add(mainPageVC, frame: pageFrame)
        
        hideAllPages()
        self.mainPageVC.view.isHidden = false
    }
    
    private func hideAllPages() {
        mainPageVC.view.isHidden = true
        moviesPageVC.view.isHidden = true
        tvshowsPageVC.view.isHidden = true
        myListVC.view.isHidden = true
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
