//
//  FactoryViewControllers.swift
//  FlicksBox
//
//  Created by sn.alekseev on 14.03.2021.
//

import UIKit

// в этом классе будут конфигурироваться наши вью контроллеры вместе с моделями
final class FactoryViewControllers {
    private init() {}
    
    class var main: UITabBarController {
        let viewControllers = [test, profile]
        for controller in viewControllers {
            controller.configureTabItem()
        }
        let mainController = MainController(with: viewControllers)
        return mainController
    }
    
    class var test: MainOutputController {
        TestViewController()
    }

    class var profile: MainOutputController {
        ProfileViewController()
    }
}
