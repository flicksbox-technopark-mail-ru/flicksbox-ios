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
        authButton.setTitle("Войти", for: .normal)
        authButton.addTarget(self, action:#selector(self.handleAuthorization), for: .touchUpInside)
        return authButton
    }()
    
    var authButtonClick: ((String, String) -> Void)?
    
    @objc func handleAuthorization(sender: UIButton){
        if let login = loginInput.text, let password = passwordInput.text {
            authButtonClick?(login, password)
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

    
    private lazy var subButton: SubButton = {
        let registrationButton = SubButton(frame: CGRect(x: bounds.midX - 100, y: subLabel.frame.maxY + 10, width: 200, height: 25))
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.addTarget(self, action:#selector(self.handleSubButton), for:.touchUpInside)
        
        return registrationButton
    }() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09495786577, green: 0.09006708115, blue: 0.08577851206, alpha: 0.7474274288)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4.0
        layer.cornerRadius = 20
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(loginInput)
        addSubview(passwordInput)
        addSubview(authButton)
        addSubview(authLabel)
        addSubview(subLabel)
        addSubview(subButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
