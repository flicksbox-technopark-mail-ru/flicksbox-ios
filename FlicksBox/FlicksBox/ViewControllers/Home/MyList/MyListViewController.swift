//
//  MyListViewController.swift
//  FlicksBox
//
//  Created by Mac-HOME on 06.04.2021.
//

import UIKit
import Botticelli

final class MyListViewController: SBViewController {
    private var model: MyListModel!
    private var contentGridView: ContentGridView!
    private var emptyResultView: MyListEmptyResultView!
    
    init(model: MyListModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    override func viewWillLayoutSubviews() {
        let sideSpace: CGFloat = 20
        emptyResultView = MyListEmptyResultView(frame: CGRect(
            x: view.bounds.minX + sideSpace,
            y: view.bounds.minY,
            width: view.bounds.width - sideSpace * 2,
            height: view.bounds.height - 300
        ))
        contentGridView = ContentGridView(frame: view.bounds)
        contentGridView.delegate = self
        
        view.addSubview(emptyResultView)
        view.addSubview(contentGridView)
        showContentGridView()
    }
    
    func loadMyListData() {
        model.loadData() { [weak self] content in
            DispatchQueue.main.async {
                if content.count == 0 {
                    self?.showEmptyResultView()
                } else {
                    self?.contentGridView.updateData(content)
                    self?.showContentGridView()
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MyListViewController: ContentGridViewDelegate {
    func didSelectCell(content: ContentInfo) {
        let viewController = FactoryViewControllers.createContentInfo(info: content)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
