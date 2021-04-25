//
//  AuthInput.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 21.04.2021.
//

import Botticelli
import UIKit

final class AuthIput: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = UITextField.BorderStyle.line
        
        let inputColor = #colorLiteral(red: 0.9802892804, green: 0.9804533124, blue: 0.9802661538, alpha: 1)
        backgroundColor = inputColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
