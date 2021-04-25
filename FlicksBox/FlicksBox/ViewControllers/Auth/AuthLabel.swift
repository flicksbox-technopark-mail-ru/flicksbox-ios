//
//  AuthLabel.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 25.04.2021.
//

import Botticelli
import UIKit

final class AuthLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = NSTextAlignment.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
