//
//  SBButton.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit

open class SBButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init with coder not implemented")
    }
    
    private func configureView() {
        tintColor = .white
    }
}
