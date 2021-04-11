//
//  HomeViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 11.04.2021.
//

import UIKit
import Botticelli

final class HomeViewController: SBViewController {
    let model = HomeModel()
    
    private lazy var tableView: UITableView  = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        let safeArea = view.layoutMarginsGuide
        var constraints = [NSLayoutConstraint]()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tableView.topAnchor.constraint(equalTo: safeArea.topAnchor))
        constraints.append(tableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor))
        constraints.append(tableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: MainOutput {
    func configureTabItem() {
        self.title = "Главная"
        self.tabBarItem.image = SBIcon.house
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sectionsInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.sectionsInfo[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
        return reusableCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        if cell.films == nil {
            cell.startAnimationLoading()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 4
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
