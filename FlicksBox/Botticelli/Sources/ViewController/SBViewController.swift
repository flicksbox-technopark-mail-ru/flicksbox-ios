//
//  SBViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit

open class SBViewController: UIViewController {
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init with coder not implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        customizeNavigationBar()
    }
    
    private func configureView() {
        view.backgroundColor = .customBlack
    }
    
    private func customizeNavigationBar() {
        guard let navController = self.navigationController else { return }
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barStyle = .black
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    
    public func alert(message: String, complition: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
            complition?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
