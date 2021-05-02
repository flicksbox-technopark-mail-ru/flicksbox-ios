//
//  AuthViewController.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 18.04.2021.
//

import Botticelli
import UIKit

final class AuthViewController: SBViewController {

    let authModel = AuthModel()

    private lazy var authView: AuthView = {

        let widthAuthView: CGFloat = view.bounds.width * 9 / 10
        let heightAuthView: CGFloat = view.bounds.height * 3 / 10
        let authView = AuthView(
            frame: CGRect(
                x: view.bounds.midX - widthAuthView/2,
                y: view.bounds.midY - heightAuthView/2,
                width: widthAuthView,
                height: heightAuthView
            )
        )
        authView.buttonClick = { [weak self] email, password in
            self?.authModel.authorization(email: email, password: password) {
                guard let viewControllerrs = self?.tabBarController?.viewControllers,
                        let self = self else {
                    return
                }
                var newViewControllers = viewControllerrs
                newViewControllers.removeLast()
                newViewControllers.append(FactoryViewControllers.profile)
                self.tabBarController?.setViewControllers(newViewControllers, animated: true)
            } failure: { (error) in
                print(error)
            }
        }
        return authView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(authView)
    }
}

extension AuthViewController: MainOutput {
    func configureTabItem() {
        self.title = "Авторизация"
        self.tabBarItem.image = SBIcon.auth
    }
}
