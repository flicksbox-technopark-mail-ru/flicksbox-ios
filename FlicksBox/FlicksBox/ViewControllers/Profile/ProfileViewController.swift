//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Botticelli
import UIKit

final class ProfileViewController: MainOutputController {
    private var viewModel = ProfileModel(username: "Alkirys", email: "example@mail.ru")

    private var userInfoView: SBView?
    private var subscriptionView: SBView?

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

            let subscribtion = ProfileSubscriptionView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 175,
                width: view.bounds.width - 50,
                height: 440
            ))
//            let subscribtion = ProfileSettingsView(frame: CGRect(
//                x: 25,
//                y: view.bounds.minY + 200,
//                width: view.bounds.width - 50,
//                height: 300
//            ), nickname: viewModel.username, email: viewModel.email)

            view.addSubview(userInfo)
            userInfoView = userInfo
            view.addSubview(subscribtion)
            subscriptionView = subscribtion

            return
        }

        userInfoView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 25,
            width: view.bounds.width - 50,
            height: 125
        )

        subscriptionView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 175,
            width: view.bounds.width - 50,
            height: 440
        )
    }
}
