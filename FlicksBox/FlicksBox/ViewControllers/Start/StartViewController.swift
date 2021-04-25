//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 25.04.2021.
//

import UIKit
import Botticelli

class StartViewController: SBViewController, StartOutput {
    let model = StartModel()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "FlicksBox"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        indicator.color = UIColor.white
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.output = self
        
        view.addSubview(label)
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.notifyWillAppear()
    }
    
    private let spaceCenter: CGFloat = 50
    
    override func viewDidLayoutSubviews() {
        label.sizeToFit()
        label.center = CGPoint(x: view.center.x, y: view.center.y - spaceCenter)
        
        activityIndicator.sizeToFit()
        activityIndicator.center = CGPoint(x: view.center.x, y: view.center.y + spaceCenter)
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.label.isHidden = false
            self?.label.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        } completion: { [weak self] _ in
            self?.activityIndicator.isHidden = false
            self?.activityIndicator.startAnimating()
        }
    }
    
    func showError(message: String, complition: @escaping () -> Void) {
        alert(message: message, complition: complition)
    }
}
