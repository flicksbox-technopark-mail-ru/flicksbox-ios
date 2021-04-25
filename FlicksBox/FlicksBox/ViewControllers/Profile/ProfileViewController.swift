//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Botticelli
import UIKit

final class ProfileViewController: SBViewController {
    private var viewModel = ProfileModel(username: "Alkirys", email: "example@mail.ru")
    
    private lazy var tableView: UITableView  = {
        let tableView = UITableView()
        tableView.register(ProfileUserInfoView.self, forCellReuseIdentifier: ProfileUserInfoView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

//    private var userInfoView: ProfileUserInfoView?
    private var subscriptionView: SBView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSubviews()
    }

    private func configureSubviews() {
        view.addSubview(tableView)
//        if userInfoView == nil {
//            let userInfo = ProfileUserInfoView(frame: CGRect(
//                x: 25,
//                y: view.bounds.minY + 25,
//                width: view.bounds.width - 50,
//                height: 125
//            ), nickname: viewModel.username, email: viewModel.email)

            let subscribtion = ProfileSubscriptionView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 175,
                width: view.bounds.width - 50,
                height: 440
            ))

//            view.addSubview(userInfo)
//            userInfoView = userInfo
            view.addSubview(subscribtion)
            subscriptionView = subscribtion

            return
//        }

//        userInfoView?.frame = CGRect(
//            x: 25,
//            y: view.bounds.minY + 25,
//            width: view.bounds.width - 50,
//            height: 125
//        )
//
//        subscriptionView?.frame = CGRect(
//            x: 25,
//            y: view.bounds.minY + 175,
//            width: view.bounds.width - 50,
//            height: 440
//        )
    }
}

extension ProfileViewController: MainOutput {
    func configureTabItem() {
        self.tabBarItem.title = "Профиль"
        self.tabBarItem.image = SBIcon.person
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserInfoView.identifier, for: indexPath)
        return cell
    }

}

extension ProfileViewController: UITableViewDelegate {}
