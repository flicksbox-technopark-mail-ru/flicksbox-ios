//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Botticelli
import UIKit

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
