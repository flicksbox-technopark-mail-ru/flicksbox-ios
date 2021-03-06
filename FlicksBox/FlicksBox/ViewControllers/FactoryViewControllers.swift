//
//  FactoryViewControllers.swift
//  FlicksBox
//
//  Created by sn.alekseev on 14.03.2021.
//

import UIKit
import Botticelli
import AVKit
import AVFoundation

// в этом классе будут конфигурироваться наши вью контроллеры вместе с моделями
final class FactoryViewControllers {
    private init() {}

    class var start: UIViewController {
        let viewController = StartViewController()
        return viewController
    }
    
    class var home: UIViewController {
        let controller = HomeViewController()
        controller.prepareForUse()
        return UINavigationController(rootViewController: controller)
    }
    
    class var free: UIViewController {
        let controller = FreeContentViewController()
        controller.prepareForUse()
        return UINavigationController(rootViewController: controller)
    }
    
    class var search: UIViewController {
        let controller = SearchViewController()
        controller.prepareForUse()
        return UINavigationController(rootViewController: controller)
    }

    class var profile: UIViewController {
        let controller = ProfileViewController()
        controller.prepareForUse()
        return UINavigationController(rootViewController: controller)
    }
    
    class var sign: UIViewController {
        let controller = AuthViewController()
        controller.title = "Вход"
        controller.tabBarItem.image = SBIcon.person
        return UINavigationController(rootViewController: controller)
    }
    
    enum MainControllerType {
        case profile
        case sign
    }
    
    static func createMain(with type: MainControllerType) -> UITabBarController {
        let viewControllers: [UIViewController]
        if case .profile = type {
            viewControllers = [home, free, search, profile]
        } else {
            viewControllers = [home, free, search, sign]
        }
        let mainController = MainController(with: viewControllers)
        return mainController
    }

    static func createContentInfo(info: ContentInfo) -> UIViewController {
        let controller = ContentInfoViewController()
        controller.contentInfo = info
        return controller
    }
    
    static func createActorContent(actor: Actor) -> UIViewController {
        let controller = ActorViewController()
        controller.actor = actor
        return controller
    }
    
    static func createPlayer(video: String) -> AVPlayerViewController? {
        let videoURL = URL(string: video)
        guard let url = videoURL else {
            return nil
        }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        return playerViewController
    }
}
