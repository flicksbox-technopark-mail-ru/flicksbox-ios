//
//  ProfileNameInputsView.swift
//  FlicksBox
//
//  Created by Alkirys on 04.06.2021.
//

import UIKit
import Botticelli

final class ProfileNameInputsView: SBView {
    let nameLabel: SBLabel
    let usernameInput: SBTextField
    let emailLabel: SBLabel
    let emailInput: SBTextField

    init(frame: CGRect, nickname: String, email: String) {
        nameLabel = SBLabel()
        usernameInput = SBTextField()
        usernameInput.attributedPlaceholder = NSAttributedString(
            string: nickname,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        emailLabel = SBLabel()
        emailInput = SBTextField()
        emailInput.attributedPlaceholder = NSAttributedString(
            string: email,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(usernameInput)
        addSubview(emailLabel)
        addSubview(emailInput)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateNameLabel()
        configurateNicknameInput()
        configurateEmailLabel()
        configurateEmailInput()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configurateView()
        configureSubviews()
    }
    
    func getData() -> UserName {
        return UserName(
            nickname: usernameInput.text ?? usernameInput.placeholder!,
            email: emailInput.text ?? emailInput.placeholder!
        )
    }
    
    func setData(username: String, email: String) {
        usernameInput.placeholder = username
        emailInput.placeholder = email
    }

    private func configurateView() {
        self.backgroundColor = UIColor(red: 18/255, green: 17/255, blue: 16/255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }

    private func configurateNameLabel() {
        nameLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: 0,
            width: self.bounds.width / 2,
            height: 20
        )

        nameLabel.text = "Имя"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 20)

        addSubview(nameLabel)
    }

    private func configurateNicknameInput() {
        usernameInput.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 30,
            width: self.bounds.width * 0.7,
            height: 40
        )

        usernameInput.tintColor = UIColor.black
        usernameInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        usernameInput.layer.cornerRadius = 5
        usernameInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(usernameInput)
    }

    private func configurateEmailLabel() {
        emailLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 80,
            width: self.bounds.width / 2,
            height: 20
        )

        emailLabel.text = "Почта"
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont.systemFont(ofSize: 20)

        addSubview(emailLabel)
    }

    private func configurateEmailInput() {
        emailInput.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 110,
            width: self.bounds.width * 0.7,
            height: 40
        )
        emailInput.tintColor = UIColor.black
        emailInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        emailInput.layer.cornerRadius = 5
        emailInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(emailInput)
    }
}
