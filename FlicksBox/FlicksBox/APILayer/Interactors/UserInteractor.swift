//
//  UserInteractor.swift
//  FlicksBox
//
//  Created by sn.alekseev on 21.03.2021.
//

import Foundation
import Hermes

struct UserSignin: Encodable {
   let email: String
   let password: String
}

final class UserInteractor {
    private let client: HermesClient

    private let encoder: JSONEncoder

    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }

     struct UserSignup: Encodable {
        let nickname: String
        let email: String
        let password: String
        let repeated_password: String
    }

    struct UserResponse: Decodable {
        let user: APIUser
    }

    func signup(
        user: UserSignup,
        success: @escaping (APIResponse<UserResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        sign(user: user, method: "/user/register", success: success, failure: failure)
    }

    func signin(
        user: UserSignin,
        success: @escaping (APIResponse<UserResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        sign(user: user, method: "/session", success: success, failure: failure)
    }

    private func sign<T>(
        user: T,
        method: String,
        success: @escaping (APIResponse<UserResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Encodable {
        guard let data = try? encoder.encode(user) else {
            failure(InteractorError.invalidEncode)
            return
        }
        let request = HermesRequest(method: .post, path: method, body: data)
        request.successHandler = { response in
            guard let data = response.data.decode(type: APIResponse<UserResponse>.self) else {
                failure(InteractorError.emptyData)
                return
            }
            if let token = response.headers["x-csrf-token"] as? String {
                CSRFStorage.shared.token = token
            }
            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }

    func profile(success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
        let request = HermesRequest(method: .get, path: "/user/profile")
        request.successHandler = { response in
            guard let data = response.data.decode(type: APIResponse<UserResponse>.self) else {
                failure(InteractorError.emptyData)
                return
            }
            if let token = response.headers["x-csrf-token"] as? String {
                CSRFStorage.shared.token = token
            }
            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
