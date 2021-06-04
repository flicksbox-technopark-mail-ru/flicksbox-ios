//
//  AuthButton.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 21.04.2021.
//

import Botticelli
import UIKit

final class SubLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textAlignment = .center
        textColor = #colorLiteral(red: 0.7214913964, green: 0.7216146588, blue: 0.7214741707, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
