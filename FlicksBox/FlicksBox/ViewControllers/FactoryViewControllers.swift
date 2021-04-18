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
        let viewControllers = [home, profile]
        let mainController = MainController(with: viewControllers)
        return mainController
    }
    
    class var home: UIViewController {
        let controller = HomeViewController()
        controller.configureTabItem()
        return UINavigationController(rootViewController: controller)
    }

    class var profile: UIViewController {
        let controller = ProfileViewController()
        controller.configureTabItem()
        return UINavigationController(rootViewController: controller)
    }
    
    static func createFilmInfo(info: FilmInfo) -> UIViewController {
        let controller = FilmInfoViewController()
        controller.filmInfo = info
        return controller
    }
}
