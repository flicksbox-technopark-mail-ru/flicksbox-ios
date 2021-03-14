//
//  FactoryViewControllers.swift
//  FlicksBox
//
//  Created by sn.alekseev on 14.03.2021.
//

import UIKit

// в этом классе будут конфигурироваться наши вью контроллеры вместе с моделями
final class FactoryViewControllers {
    static let shared = FactoryViewControllers()
    
    private init() {}

    func start() -> UIViewController {
        StartViewController()
    }
    
    func sign() -> UIViewController {
        SignViewController()
    }
}
