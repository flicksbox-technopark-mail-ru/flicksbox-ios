import Botticelli
import UIKit


final class RegistrationView: UIView {

    private lazy var authLabel: AuthLabel = {
        let authLabel = AuthLabel(frame: CGRect(x: 20, y: 10, width: bounds.maxX - 40, height: 30))
        authLabel.text = "Регистрация"
        return authLabel
    }()
    
    private lazy var loginInput: AuthIput = {
        let loginInput = AuthIput(frame: CGRect(x: 10, y: authLabel.frame.maxY + 30, width: bounds.maxX - 20, height: 40))
        loginInput.placeholder = "Введите логин"
        return loginInput
    }()
    
    private lazy var emailInput: AuthIput = {
        let emailInput = AuthIput(frame: CGRect(x: 10, y: loginInput.frame.maxY + 30, width: bounds.maxX - 20, height: 40))
        emailInput.placeholder = "Введите e-mail"
        return emailInput
    }()
    
    private lazy var passwordInput: AuthIput = {
        let passwordInput = AuthIput(frame: CGRect(x: 10, y: emailInput.frame.maxY + 30, width: bounds.maxX - 20, height: 40))
        passwordInput.placeholder = "Введите пароль"
        passwordInput.isSecureTextEntry = true
        return passwordInput
    }()
    
    private lazy var repeatPasswordInput: AuthIput = {
        let repeatPasswordInput = AuthIput(frame: CGRect(x: 10, y: passwordInput.frame.maxY + 30, width: bounds.maxX - 20, height: 40))
        repeatPasswordInput.placeholder = "Повторите пароль"
        repeatPasswordInput.isSecureTextEntry = true
        return repeatPasswordInput
    }()
    
    private lazy var authButton: AuthButton = {
        let authButton = AuthButton(frame: CGRect(x: 10, y: repeatPasswordInput.frame.maxY + 35, width: bounds.maxX - 20, height: 40))
        authButton.setTitle("Зарегистрироваться", for: .normal)
        authButton.addTarget(self, action:#selector(self.handleRegistration), for: .touchUpInside)
        return authButton
    }()
    
    var registrationButtonClick: ((String, String, String, String) -> Void)?
    
    @objc func handleRegistration(sender: UIButton){
        if let login = loginInput.text, let email = emailInput.text,let password = passwordInput.text, let repeatPassword = repeatPasswordInput.text  {
            registrationButtonClick?(login, email, password, repeatPassword)
        }
    }
    
    private lazy var subLabel: SubLabel = {
        let registrationLabel = SubLabel(frame: CGRect(x: 0, y: authButton.frame.maxY + 20, width: bounds.width, height: 25))
        registrationLabel.text = "Уже зарегистрированы?"
        
        return registrationLabel;
    }()
    
    private lazy var subButton: SubButton = {
        let registrationButton = SubButton(frame: CGRect(x: bounds.midX - 100, y: subLabel.frame.maxY + 10, width: 200, height: 25))
        registrationButton.setTitle("Войти", for: .normal)
        registrationButton.addTarget(self, action:#selector(self.handleSubButton(sender:)), for: .touchUpInside)
        
        return registrationButton
    }()
    
    var subButtonClick:(() -> Void)?
    
    @objc func handleSubButton(sender: UIButton) {
        subButtonClick?()
    }
    
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
        addSubview(authLabel)
        addSubview(loginInput)
        addSubview(emailInput)
        addSubview(passwordInput)
        addSubview(repeatPasswordInput)
        addSubview(authButton)
        addSubview(subLabel)
        addSubview(subButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
