//
//  ActorViewController.swift
//  FlicksBox
//
//  Created by Mac-HOME on 01.06.2021.
//

import UIKit
import Botticelli

final class ActorViewController: SBViewController {
    var actor: Actor? {
        didSet {
            self.title = actor?.name
        }
    }
    
    private var model = ActorModel()
    private var contentGridView: ContentGridView!
    private var emptyResultView: ActorEmptyResultView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillLayoutSubviews() {
        let sideSpace: CGFloat = 20
        emptyResultView = ActorEmptyResultView(frame: CGRect(
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
        loadContent()
    }
    
    func loadContent() {
        guard let actor = actor else { return }
        
        model.loadData(actor: actor) { [weak self] content in
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

extension ActorViewController: ContentGridViewDelegate {
    func didSelectCell(content: ContentInfo) {
        let viewController = FactoryViewControllers.createFilmInfo(info: content)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
