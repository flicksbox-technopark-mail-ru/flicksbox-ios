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
    }
    
    private func configureView() {
        view.backgroundColor = .black
    }
    
    public func alert(message: String, complition: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
            complition?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
