//
//  AuthModel.swift
//  FlicksBox
//
//  Created by Александр Бутолин on 25.04.2021.
//

import Foundation

struct User {
    let avatar: String
    let email: String
    let id: Int
    let nickname: String
    
    init(from user: APIUser) {
        self.init(id: user.id, nickname: user.nickname, email: user.email, avatar: user.avatar)
    }
    
    init(id: Int, nickname: String, email: String, avatar: String) {
        self.id = id
        self.nickname = nickname
        self.email = email
        self.avatar = avatar
    }
}

final class AuthModel: NSObject {
    private let userInteractor = UserInteractor()
    
    func authorization(email: String, password: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        
        let userSignin = UserSignin(email: email, password: password)
        
        userInteractor.signin(user: userSignin) { response in
            if let error = response.error {
                failure(error.user_message)
                return
            }
            guard let user = response.body?.user else {
                failure("Неизвестная ошибка")
                return
            }
            ClientUser.shared.setFromApi(user: user)
            DispatchQueue.main.async {
                success()
            }
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(user: APIUser) -> User {
        User(from: user)
    }
}
