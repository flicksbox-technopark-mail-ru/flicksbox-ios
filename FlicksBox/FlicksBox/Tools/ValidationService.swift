import Foundation

/* соглашения об ошибках сервиса валидации
 *  1 - ошибка логина - не обрабатываем, потому что является не обязательным полем
 *  2 - ошибка пароля
 *  3 - ошибка повторенного пароля
 *  4 - ошибка email
 */

final class ValidationService {
    
    struct Error {
        var code = 0
        var text = ""
    }
    
    static var shared: ValidationService = {
            let instance = ValidationService()
            return instance
        }()
    
    private init() {}
    
    func isValidLoginForm(email: String, password: String) -> [Error]{
        var errors: [Error] = []
        var error = checkEmail(email: email)
        errors.append(error)
        error = checkPassword(password: password)
        errors.append(error)
        return errors
    }
    
    func isValidRegistrationForm(login: String, email: String, password: String, repeatPassword: String) -> [Error]{
        var errors: [Error] = []
        var error = checkEmail(email: email)
        errors.append(error)
        error = checkPassword(password: password)
        errors.append(error)
        error = checkRepeatPassword(password: password, repeatPassword: repeatPassword)
        errors.append(error)
        return errors
    }
    
    func checkLogin(login: String) -> Error{
        var error = Error(code: 0, text: "")
        if (login.count < 6) {
            error.code = 1
            error.text = "Короткий логин"
        }
        return error
    }
    
    func checkPassword(password: String) -> Error{
        var error = Error(code: 0, text: "")
        if (password.count < 6) {
            error.code = 2
            error.text = "Короткий пароль"
        }
        return error
    }
    
    func checkRepeatPassword(password: String, repeatPassword: String) -> Error{
        var error = Error(code: 0, text: "")
        if (password != repeatPassword) {
            error.code = 3
            error.text = "Пароли не совпали"
        }
        return error
    }
    
    func checkEmail(email: String) -> Error{
        var error = Error(code: 0, text: "")
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if (!NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)) {
            error.code = 4
            error.text = "Неправильный форма Email"
        }
        return error
    }
}
