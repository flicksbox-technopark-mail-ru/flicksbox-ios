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
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeTableViewHeader(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.titleLabel.text = model.sectionsInfo[section].name
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        
        if let _ = cell.films {
            return
        }
        
        cell.startAnimationLoading(animated: true)
        model.loadSection(index: indexPath.section) { [weak cell, weak self] films in
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

extension HomeViewController: UITableViewDelegate {}

private class HomeTableViewHeader: SBView {
    lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    private func configureSubviews() {
        let sideSpacing: CGFloat = 20
        let height: CGFloat = 22
        titleLabel.frame = CGRect.init(
            x: sideSpacing,
            y: bounds.maxY - height,
            width: bounds.width - sideSpacing * 2,
            height: bounds.height - height
        )
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
