import Botticelli
import UIKit

final class AuthViewController: SBViewController {
    
    let authModel = AuthModel()
    
    private lazy var authView: AuthView = {
        
        let widthAuthView: CGFloat = view.bounds.width * 9 / 10
        let heightAuthView: CGFloat = 380
        let authView = AuthView(frame: CGRect(x: view.bounds.midX - widthAuthView/2, y: view.bounds.midY - heightAuthView/2, width: widthAuthView, height: heightAuthView))
        
        authView.authButtonClick = { [weak self] email, password in
            self?.authModel.authorization(email: email, password: password) {
                guard let viewControllerrs = self?.tabBarController?.viewControllers,
                        let self = self else {
                    return
                }
                var newViewControllers = viewControllerrs
                newViewControllers.removeLast()
                newViewControllers.append(FactoryViewControllers.profile)
                self.tabBarController?.setViewControllers(newViewControllers, animated: true)
            } failure: { (error) in
                print(error)
            }
        }
        
        authView.subButtonClick = {
            self.changeForm()
        }
        
        return authView
    }()
    
    private lazy var registrationView: RegistrationView = {
        
        let widthAuthView: CGFloat = view.bounds.width * 9 / 10
        let heightAuthView: CGFloat = 520
        let registrationView = RegistrationView(frame: CGRect(x: view.bounds.midX - widthAuthView/2, y: view.bounds.midY - heightAuthView/2, width: widthAuthView, height: heightAuthView))
        
        registrationView.registrationButtonClick = { [weak self] login, email, password, repeatPassword in
            self?.authModel.registration(login: login, email: email, password: password, repeatPassword: repeatPassword) {
                guard let viewControllerrs = self?.tabBarController?.viewControllers,
                        let self = self else {
                    return
                }
                var newViewControllers = viewControllerrs
                newViewControllers.removeLast()
                newViewControllers.append(FactoryViewControllers.profile)
                self.tabBarController?.setViewControllers(newViewControllers, animated: true)
            } failure: { (error) in
                print(error)
            }
        }
        
        registrationView.subButtonClick = {
            self.changeForm()
        }
        
        return registrationView
    }()

    private func changeForm() {
        if authView.isDescendant(of: view) {
            authView.removeFromSuperview()
            view.addSubview(registrationView)
        } else {
            registrationView.removeFromSuperview()
            view.addSubview(authView)
        }
    }
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.origin.y = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupSubviews()
        configureGestures()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    if self.view.frame.origin.y == 0 {
                        self.view.frame.origin.y -= keyboardSize.height * 0.2
                    }
                }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupSubviews() {
        view.addSubview(authView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
