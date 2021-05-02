//
//  ClientUser.swift
//  FlicksBox
//
//  Created by sn.alekseev on 25.04.2021.
//

import Foundation

struct UserData: Codable {
    let avatar: String
    let email: String
    let id: Int
    let nickname: String
}

final class ClientUser {
    static let shared = ClientUser()

    var userData: UserData? {
        didSet {
            if userData == nil {
                clearCookies()
            }
        }
    }

    func setFromApi(user: APIUser) {
        userData = .init(avatar: user.avatar, email: user.email, id: user.id, nickname: user.nickname)
    }

    private init() {}

    private func clearCookies() {
        let storage = HTTPCookieStorage.shared
        guard let cookies = storage.cookies else {
            return
        }

        for cookie in cookies {
            storage.deleteCookie(cookie)
        }
    }
}
