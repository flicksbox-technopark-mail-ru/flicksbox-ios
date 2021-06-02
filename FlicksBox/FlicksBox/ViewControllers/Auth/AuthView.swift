//
//  AuthView.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 19.04.2021.
//

import Botticelli
import UIKit


final class AuthView: UIView {

    private lazy var authLabel: AuthLabel = {
        let authLabel = AuthLabel(frame: CGRect(x: 20, y: 10, width: bounds.maxX - 40, height: 30))
        authLabel.text = "Авторизация"
        return authLabel
    }()
    
    private lazy var loginInput: AuthIput = {
        let loginInput = AuthIput(frame: CGRect(x: 10, y: authLabel.frame.maxY + 30, width: bounds.maxX - 20, height: 40))
        loginInput.keyboardType = .emailAddress
        loginInput.autocorrectionType = .no
        loginInput.autocapitalizationType = .none
        loginInput.placeholder = "Введите логин"
        return loginInput
    }()
    
    private lazy var passwordInput: AuthIput = {
        let passwordInput = AuthIput(frame: CGRect(x: 10, y: loginInput.frame.maxY + 40, width: bounds.maxX - 20, height: 40))
        passwordInput.placeholder = "Введите пароль"
        passwordInput.isSecureTextEntry = true
        return passwordInput
    }()
    
    private lazy var authButton: AuthButton = {
        let authButton = AuthButton(frame: CGRect(x: 10, y: passwordInput.frame.maxY + 35, width: bounds.maxX - 20, height: 40))
        authButton.addTarget(self, action:#selector(self.handleRegister), for: .touchUpInside)
        return authButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09495786577, green: 0.09006708115, blue: 0.08577851206, alpha: 0.7474274288)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        layer.cornerRadius = 20
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(loginInput)
        addSubview(passwordInput)
        addSubview(authButton)
        addSubview(authLabel)
    }
    
    var buttonClick: ((String, String) -> Void)?
    
    @objc func handleRegister(sender: UIButton){
        if let login = loginInput.text, let password = passwordInput.text {
            buttonClick?(login, password)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
