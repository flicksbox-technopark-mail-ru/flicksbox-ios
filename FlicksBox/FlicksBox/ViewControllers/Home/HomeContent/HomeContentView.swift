//
//  HomeContentView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 21.05.2021.
//

import UIKit
import Botticelli

class HomeContentViewController: SBViewController {
    private var model: PageModel!
    private lazy var previewHeaderHeight: CGFloat = (view.bounds.width / 16 * 9) + 160
    
    private lazy var previewHeader: HomePreviewHeader = {
        let viewFrame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: previewHeaderHeight)
        let ph = HomePreviewHeader(frame: viewFrame, content: [])
        ph.previewSliderView.delegate = self
        return ph
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()

    init(model: PageModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        view.addSubview(tableView)
        loadPreviewContent()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func loadPreviewContent() {
        model.loadPreviewData() { [weak self] content in
            DispatchQueue.main.async {
                self?.previewHeader.setPreviewContent(content: content)
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HomeContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sectionsCount
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            previewHeader.setTitle(title: model.getSectionName(section))
            return previewHeader
        } else {
            let tableViewHeader = HomeTableViewHeader(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 50))
            tableViewHeader.title = model.getSectionName(section)
            return tableViewHeader
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return previewHeaderHeight
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        HomeTableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        guard cell.films == nil else { return }

        model.loadSectionData(section: indexPath.section) { [weak cell, weak self] films in
            DispatchQueue.main.async {
                cell?.navigationController = self?.navigationController
                cell?.films = films
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        max(view.bounds.width, view.bounds.height) / 5
    }
}

extension HomeContentViewController: UITableViewDelegate {}

extension HomeContentViewController: PreviewSliderViewDelegate {
    func didSelectCell(content: ContentInfo) {
        let viewController = FactoryViewControllers.createContentInfo(info: content)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
