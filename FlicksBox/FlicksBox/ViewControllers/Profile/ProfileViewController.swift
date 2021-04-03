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
        configureSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSubviews()
    }
    
    func configureTabItem() {
        self.tabBarItem.title = "Профиль"
        self.tabBarItem.image = SBIcon.person
    }
    
    private func configureSubviews() {
        if (userInfoView == nil) {
            let userInfo = ProfileUserInfoView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 50,
                width: view.bounds.width - 50,
                height: 125
            ), nickname: viewModel.username, email: viewModel.email)
            
            let subscribtion = ProfileSubscriptionView(frame: CGRect(
                x: 25,
                y: view.bounds.minY + 200,
                width: view.bounds.width - 50,
                height: 300
            ))
            
            view.addSubview(userInfo)
            userInfoView = userInfo
            view.addSubview(subscribtion)
            subscriptionView = subscribtion
            
            return
        }
        
        userInfoView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 50,
            width: view.bounds.width - 50,
            height: 125
        )
        
        subscriptionView?.frame = CGRect(
            x: 25,
            y: view.bounds.minY + 200,
            width: view.bounds.width - 50,
            height: 410
        )
    }
}
