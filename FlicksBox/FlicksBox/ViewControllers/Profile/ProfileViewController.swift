//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit
import Botticelli

class ProfileViewController: MainOutputController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureTabItem() {
        self.tabBarItem.title = "Профиль"
        self.tabBarItem.image = SBIcon.person
    }
}
