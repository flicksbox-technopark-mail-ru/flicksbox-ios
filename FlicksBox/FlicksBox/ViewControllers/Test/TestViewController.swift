//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit
import Botticelli

final class TestViewController: MainOutputController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        testRequest()
    }

    func configureTabItem() {
        self.tabBarItem.title = "Тест"
        self.tabBarItem.image = SBIcon.house
    }

    private func configureSubviews() {
        let label = SBLabel()
        label.frame = CGRect(
            x: view.bounds.midX - 100,
            y: view.bounds.midY - 50,
            width: 200,
            height: 100
        )
        label.text = "Приложение работает"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)

        let button = SBButton()
        button.frame = CGRect(
            x: label.frame.minX,
            y: label.frame.maxY + 20,
            width: 200,
            height: 100
        )
        button.setTitle("Открыть сайт", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(self.presentSite), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func presentSite() {
        let vc = SBBrowserController(url: URL(string: "https://www.flicksbox.ru")!)
        present(vc, animated: true, completion: nil)
    }

    private func testRequest() {
        let interactor = UserInteractor()
        // пример регистрации
        interactor.signup(user: .init(
                            nickname: "testsss3",
                            email: "haha3@dasdads.com",
                            password: "12345678",
                            repeatedPassword: "12345678"
        )) { response in
            print(response)
        } failure: { error in
            print(error)
        }
        // пример авторизации
        interactor.signin(user: .init(email: "haha3@dasdads.com", password: "12345678")) { response in
            print(response)
        } failure: { error in
            print(error)
        }

    }
}
