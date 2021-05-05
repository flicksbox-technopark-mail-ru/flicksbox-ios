//
//  AuthButton.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 21.04.2021.
//

import Botticelli
import UIKit

final class SubButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
