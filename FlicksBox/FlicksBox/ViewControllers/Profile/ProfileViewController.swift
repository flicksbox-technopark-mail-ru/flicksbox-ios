//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Botticelli
import UIKit

//final class ProfileViewController: SBViewController {
//    private var viewModel = ProfileModel(username: "Alkirys", email: "example@mail.ru")
//
//    private lazy var tableView: UITableView  = {
//        let tableView = UITableView()
//        tableView.register(ProfileUserInfoView.self, forCellReuseIdentifier: ProfileUserInfoView.identifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.tableFooterView = UIView(frame: .zero)
//        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = UIColor.black
//        return tableView
//    }()
//
////    private var userInfoView: ProfileUserInfoView?
//    private var subscriptionView: SBView?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureSubviews()
////        tableView.estimatedRowHeight = tableView.rowHeight
////        tableView.rowHeight = UITableView.automaticDimension
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        configureSubviews()
//    }
//
//    private func configureSubviews() {
//        tableView.frame = CGRect(
//            x: 25,
//            y: view.bounds.minY + 10,
//            width: view.bounds.width - 50,
//            height: view.bounds.height - 10
//        )
//        view.addSubview(tableView)
//
////        if userInfoView == nil {
////            let userInfo = ProfileUserInfoView(frame: CGRect(
////                x: 25,
////                y: view.bounds.minY + 25,
////                width: view.bounds.width - 50,
////                height: 125
////            ), nickname: viewModel.username, email: viewModel.email)
//
////            let subscribtion = ProfileSubscriptionView(frame: CGRect(
////                x: 25,
////                y: view.bounds.minY + 175,
////                width: view.bounds.width - 50,
////                height: 440
////            ))
//
////            view.addSubview(userInfo)
////            userInfoView = userInfo
//            // view.addSubview(subscribtion)
//            // subscriptionView = subscribtion
//
//            return
////        }
//
////        userInfoView?.frame = CGRect(
////            x: 25,
////            y: view.bounds.minY + 25,
////            width: view.bounds.width - 50,
////            height: 125
////        )
////
////        subscriptionView?.frame = CGRect(
////            x: 25,
////            y: view.bounds.minY + 175,
////            width: view.bounds.width - 50,
////            height: 440
////        )
//    }
//}
//
//extension ProfileViewController: MainOutput {
//    func configureTabItem() {
//        self.tabBarItem.title = "Профиль"
//        self.tabBarItem.image = SBIcon.person
//    }
//}
//
//extension ProfileViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 125.0;//Choose your custom row height
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserInfoView.identifier, for: indexPath)
////        cell.frame = CGRect(
////            x: 25,
////            y: 0,
////            width: tableView.bounds.width - 50,
////            height: 500
////        )
//        return cell
//    }
//}
//
//extension ProfileViewController: UITableViewDelegate {}


final class ProfileViewController: MainOutputController {
    private var viewModel = ProfileModel(username: ClientUser.shared.userData!.nickname, email: ClientUser.shared.userData!.email)

    private var userInfoView: SBView?
    private var subscriptionView: SBView?
    private var settingsView: ProfileSettingsView?
    private var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        configureSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurateView()
        configureSubviews()
    }

    func configureTabItem() {
        self.tabBarItem.title = "Профиль"
        self.tabBarItem.image = SBIcon.person
    }

    private func configurateView() {
        self.scrollView.frame = view.bounds
        self.scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: 605 // высота userInfoView + subscriptionView + отступы
        )
        view.addSubview(self.scrollView)
//        self.view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
    }

    private func configureSubviews() {
        if userInfoView == nil {
            let userInfo = ProfileUserInfoView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 25,
                width: view.bounds.width - 50,
                height: 125
            ), nickname: viewModel.username, email: viewModel.email)
            
            userInfo.exitProfile = { [weak self] in
                guard let viewControllerrs = self?.tabBarController?.viewControllers,
                        let self = self else {
                    return
                }
                var newViewControllers = viewControllerrs
                newViewControllers.removeLast()
                newViewControllers.append(FactoryViewControllers.sign)
                self.tabBarController?.setViewControllers(newViewControllers, animated: true)
            }

            let settings = ProfileSettingsView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 175,
                width: view.bounds.width - 50,
                height: 405
            ), nickname: viewModel.username, email: viewModel.email)
            
            settings.changeUserInfo = { [weak self] nickname, email in
                guard let viewControllerrs = self?.tabBarController?.viewControllers,
                        let self = self else {
                    return
                }
                (self.userInfoView as! ProfileUserInfoView).changeUserData(nickname: nickname, email: email)
            }
            
//            let subscribtion = ProfileSettingsView(frame: CGRect(
//                x: 25,
//                y: view.bounds.minY + 200,
//                width: view.bounds.width - 50,
//                height: 300
//            ), nickname: viewModel.username, email: viewModel.email)
            self.scrollView.addSubview(userInfo)
            userInfoView = userInfo
            self.scrollView.addSubview(settings)
            subscriptionView = settings

            return
        }

        userInfoView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 25,
            width: view.bounds.width - 50,
            height: 125
        )

        settingsView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 175,
            width: view.bounds.width - 50,
            height: 440
        )
    }
}
