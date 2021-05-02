//
//  StartModel.swift
//  FlicksBox
//
//  Created by sn.alekseev on 25.04.2021.
//

import UIKit

protocol StartOutput: class {
    func animate()
    func showError(message: String, complition: @escaping () -> Void)
}

final class StartModel {
    weak var output: StartOutput?

    let interactor = UserInteractor()

    func notifyWillAppear() {
        output?.animate()

        checkProfile()
    }

    private func checkProfile() {
        interactor.profile { [weak self] response in
            let type: FactoryViewControllers.MainControllerType
            if let user = response.body?.user {
                ClientUser.shared.setFromApi(user: user)
                type = .profile
            } else {
                type = .sign
            }
            DispatchQueue.main.async {
                self?.showMainController(mainType: type)
            }
        } failure: { [weak self] error in
            self?.output?.showError(message: error.localizedDescription, complition: {
                self?.checkProfile()
            })
        }
    }

    private func showMainController(mainType: FactoryViewControllers.MainControllerType) {
        let window = UIApplication.shared.windows[0]
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            let main = FactoryViewControllers.createMain(with: mainType)
            window.rootViewController = main
        }
    }
}
