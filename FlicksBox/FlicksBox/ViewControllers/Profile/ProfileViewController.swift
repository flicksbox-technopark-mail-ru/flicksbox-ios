//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import Botticelli

final class ProfileViewController: SBViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfileViewController: MainOutput {
    func configureTabItem() {
        self.title = "Профиль"
        self.tabBarItem.image = SBIcon.person
    }
}
