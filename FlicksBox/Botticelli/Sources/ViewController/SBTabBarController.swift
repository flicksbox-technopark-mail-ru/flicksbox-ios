//
//  SBTabBarController.swift
//  Botticelli
//
//  Created by sn.alekseev on 20.03.2021.
//

import UIKit

open class SBTabBarController: UITabBarController {
    public convenience init(with viewControllers: [UIViewController]) {
        self.init()
        self.setViewControllers(viewControllers, animated: false)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init with coder not implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        tabBar.barTintColor = .customBlack
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.isTranslucent = false
        view.tintColor = .white
    }
}
