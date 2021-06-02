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
    
    private lazy var loginErrorLabel: UILabel = {
        let loginErrorLabel = UILabel(frame: CGRect(x: 10, y: loginInput.frame.maxY + 10, width: bounds.maxX - 20, height: 20))
        loginErrorLabel.text = "Короткий логин"
        loginErrorLabel.textColor = UIColor.red
        loginErrorLabel.textAlignment = .center
        loginErrorLabel.isHidden = true;
        return loginErrorLabel
    }()
    
    private lazy var emailInput: AuthIput = {
        let emailInput = AuthIput(frame: CGRect(x: 10, y: loginInput.frame.maxY + 40, width: bounds.maxX - 20, height: 40))
        emailInput.placeholder = "Введите e-mail"
        return emailInput
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let emailErrorLabel = UILabel(frame: CGRect(x: 10, y: emailInput.frame.maxY + 10, width: bounds.maxX - 20, height: 20))
        emailErrorLabel.text = "Неправильный формат Email"
        emailErrorLabel.textColor = UIColor.red
        emailErrorLabel.textAlignment = .center
        emailErrorLabel.isHidden = true;
        return emailErrorLabel
    }()
    
    private lazy var passwordInput: AuthIput = {
        let passwordInput = AuthIput(frame: CGRect(x: 10, y: emailInput.frame.maxY + 40, width: bounds.maxX - 20, height: 40))
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
    
    private lazy var repeatPasswordInput: AuthIput = {
        let repeatPasswordInput = AuthIput(frame: CGRect(x: 10, y: passwordInput.frame.maxY + 40, width: bounds.maxX - 20, height: 40))
        repeatPasswordInput.placeholder = "Повторите пароль"
        repeatPasswordInput.isSecureTextEntry = true
        return repeatPasswordInput
    }()
    
    private lazy var repeatPasswordErrorLabel: UILabel = {
        let repeatPasswordErrorLabel = UILabel(frame: CGRect(x: 10, y: repeatPasswordInput.frame.maxY + 10, width: bounds.maxX - 20, height: 20))
        repeatPasswordErrorLabel.text = "Пароль не совпадают"
        repeatPasswordErrorLabel.textColor = UIColor.red
        repeatPasswordErrorLabel.textAlignment = .center
        repeatPasswordErrorLabel.isHidden = true;
        return repeatPasswordErrorLabel
    }()
    
    private lazy var authButton: AuthButton = {
        let authButton = AuthButton(frame: CGRect(x: 10, y: repeatPasswordInput.frame.maxY + 35, width: bounds.maxX - 20, height: 40))
        authButton.setTitle("Зарегистрироваться", for: .normal)
        authButton.addTarget(self, action:#selector(self.handleRegistration), for: .touchUpInside)
        return authButton
    }()
    
    var registrationButtonClick: ((String, String, String, String) -> Void)?
    
    @objc func handleRegistration(sender: UIButton){
        loginErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        repeatPasswordErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        if let login = loginInput.text, let email = emailInput.text,let password = passwordInput.text, let repeatPassword = repeatPasswordInput.text  {
            let validationService = ValidationService.shared
            let errors = validationService.isValidRegistrationForm(login: login, email: email, password: password, repeatPassword: repeatPassword)
            for item in errors {
                if (item.code == 1) {
                    loginErrorLabel.isHidden = false
                }
                else if (item.code == 2) {
                    passwordErrorLabel.isHidden = false
                }
                else if (item.code == 3) {
                    repeatPasswordErrorLabel.isHidden = false;
                }
                else if (item.code == 4) {
                    emailErrorLabel.isHidden = false;
                }
                else {
                    registrationButtonClick?(login, email, password, repeatPassword)
                }
            }
            }
        }
    
    private lazy var subLabel: SubLabel = {
        let registrationLabel = SubLabel(frame: CGRect(x: 0, y: authButton.frame.maxY + 20, width: bounds.width, height: 25))
        registrationLabel.text = "Уже зарегистрированы?"
        
        return registrationLabel;
    }()
    
    @objc func handleSubButton(sender: UIButton) {
        subButtonClick?()
    }
    
    var subButtonClick:(() -> Void)?
    
    private lazy var subAuthButton: SubButton = {
        let subRegistrButton = SubButton(frame: CGRect(x: bounds.midX - 100, y: subLabel.frame.maxY + 10, width: 200, height: 25))
        subRegistrButton.setTitle("Войти", for: .normal)
        subRegistrButton.addTarget(self, action:#selector(self.handleSubButton), for:.touchUpInside)
        return subRegistrButton
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
        addSubview(authLabel)
        addSubview(loginInput)
        addSubview(emailInput)
        addSubview(passwordInput)
        addSubview(repeatPasswordInput)
        addSubview(authButton)
        addSubview(subLabel)
        addSubview(subAuthButton)
        addSubview(loginErrorLabel)
        addSubview(emailErrorLabel)
        addSubview(passwordErrorLabel)
        addSubview(repeatPasswordErrorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
