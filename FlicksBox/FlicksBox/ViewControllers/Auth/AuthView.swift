import Botticelli
import UIKit

final class AuthView: UIView {
    
    private lazy var authLabel: AuthLabel = {
        let authLabel = AuthLabel(frame: CGRect(x: 20, y: 15, width: bounds.maxX - 40, height: 30))
        authLabel.text = "Авторизация"
        authLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return authLabel
    }()
    
    private lazy var loginInput: AuthIput = {
        let loginInput = AuthIput(frame: CGRect(x: 10, y: authLabel.frame.maxY + 25, width: bounds.maxX - 20, height: 40))
        loginInput.keyboardType = .emailAddress
        loginInput.autocorrectionType = .no
        loginInput.autocapitalizationType = .none
        loginInput.placeholder = "Введите email"
        return loginInput
    }()
    
    private lazy var loginErrorLabel: UILabel = {
        let loginErrorLabel = UILabel(frame: CGRect(x: 10, y: loginInput.frame.maxY + 10, width: bounds.maxX - 20, height: 20))
        loginErrorLabel.text = "Неправильный формат Email"
        loginErrorLabel.textColor = UIColor.red
        loginErrorLabel.textAlignment = .center
        loginErrorLabel.isHidden = true;
        return loginErrorLabel
    }()
    
    private lazy var passwordInput: AuthIput = {
        let passwordInput = AuthIput(frame: CGRect(x: 10, y: loginInput.frame.maxY + 40, width: bounds.maxX - 20, height: 40))
        passwordInput.placeholder = "Введите пароль"
        passwordInput.isSecureTextEntry = true
        return passwordInput
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let passwordErrorLabel = UILabel(frame: CGRect(x: 10, y: passwordInput.frame.maxY + 10, width: bounds.maxX - 20, height: 20))
        passwordErrorLabel.text = "Короткий пароль"
        passwordErrorLabel.textColor = UIColor.red
        passwordErrorLabel.textAlignment = .center
        passwordErrorLabel.isHidden = true;
        return passwordErrorLabel
    }()
    
    private lazy var authButton: AuthButton = {
        let authButton = AuthButton(frame: CGRect(x: 10, y: passwordInput.frame.maxY + 35, width: bounds.maxX - 20, height: 40))
        authButton.setTitle("Войти", for: .normal)
        authButton.addTarget(self, action:#selector(self.handleAuthorization), for: .touchUpInside)
        return authButton
    }()
    
    var authButtonClick: ((String, String) -> Void)?
    
    @objc func handleAuthorization(sender: UIButton){
        loginErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        if let email = loginInput.text, let password = passwordInput.text {
            let validationService = ValidationService.shared
            let errors = validationService.isValidLoginForm(email: email, password: password)
            for item in errors {
                if (item.code == 4) {
                    loginErrorLabel.isHidden = false
                }
                else if (item.code == 2) {
                    passwordErrorLabel.isHidden = false
                }
                else {
                    authButtonClick?(email, password)
                }
            }
        }
    }
    
    private lazy var subLabel: SubLabel = {
        let registrationLabel = SubLabel(frame: CGRect(x: 0, y: authButton.frame.maxY + 20, width: bounds.width, height: 25))
        registrationLabel.text = "Еще не зарегистрированы?"
        return registrationLabel;
    }()
    
    
    var subButtonClick:(() -> Void)?
    
    @objc func handleSubButton(sender: UIButton) {
        subButtonClick?()
    }
    
    private lazy var subRegistrButton: SubButton = {
        let subRegistrButton = SubButton(frame: CGRect(x: bounds.midX - 100, y: subLabel.frame.maxY + 10, width: 200, height: 25))
        subRegistrButton.setTitle("Зарегистрироваться", for: .normal)
        subRegistrButton.addTarget(self, action:#selector(self.handleSubButton), for:.touchUpInside)
        return subRegistrButton
    }() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09495786577, green: 0.09006708115, blue: 0.08577851206, alpha: 0.7474274288)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4.0
        layer.cornerRadius = 5
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(loginInput)
        addSubview(passwordInput)
        addSubview(authButton)
        addSubview(authLabel)
        addSubview(subLabel)
        addSubview(subRegistrButton)
        addSubview(loginErrorLabel)
        addSubview(passwordErrorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
