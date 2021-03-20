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
    
    class var main: UIViewController {
        let viewControllers = [test, profile]
        if let mainOutputs = viewControllers as? [MainOutput] {
            for output in mainOutputs {
                output.configureTabItem()
            }
        }
        let mainController = MainController(with: viewControllers)
        return mainController
    }
    
    class var test: UIViewController {
        TestViewController()
    }

    class var profile: UIViewController {
        ProfileViewController()
    }
}
