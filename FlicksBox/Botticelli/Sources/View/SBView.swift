//
//  SBView.swift
//  Botticelli
//
//  Created by Mac-HOME on 02.04.2021.
//

import UIKit

open class SBView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init with coder not implemented")
    }
    
    private func configureView() {
        backgroundColor = .customBlack
    }
}

extension SBView {
    func fadeIn(_ duration: TimeInterval? = 0.1, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(
            withDuration: duration!,
            animations: { self.alpha = 1 },
            completion: { (value: Bool) in
                if let complete = onCompletion { complete() }
            }
        )
    }

    func fadeOut(_ duration: TimeInterval? = 0.1, onCompletion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration!,
            animations: { self.alpha = 0 },
            completion: { (value: Bool) in
                self.isHidden = true
                if let complete = onCompletion { complete() }
            }
        )
    }
}

extension UIColor {
    static public let customBlack = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}
