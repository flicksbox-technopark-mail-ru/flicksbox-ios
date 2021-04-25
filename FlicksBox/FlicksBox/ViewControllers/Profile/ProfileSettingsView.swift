//
//  ProfileSettingsView.swift
//  FlicksBox
//
//  Created by Alkirys on 04.04.2021.
//

import UIKit
import Botticelli

final class ProfileSettingsView: SBView {
    let nameLabel: SBLabel
    let usernameInput: SBTextField
    let emailLabel: SBLabel
    let emailInput: SBTextField
    let saveButton: SBButton

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
        saveButton = SBButton()
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(usernameInput)
        addSubview(emailLabel)
        addSubview(emailInput)
        addSubview(saveButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateNameLabel()
        configurateNicknameInput()
        configurateEmailLabel()
        configurateEmailInput()
        configurateSaveButton()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configurateView()
        configureSubviews()
    }

    private func configurateView() {
        self.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }

    private func configurateNameLabel() {
        nameLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 25,
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
            y: self.bounds.minY + 70,
            width: self.bounds.width * 0.7,
            height: 40
        )

        usernameInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        usernameInput.layer.cornerRadius = 5
        usernameInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(usernameInput)
    }

    private func configurateEmailLabel() {
        emailLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 135,
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
            y: self.bounds.minY + 180,
            width: self.bounds.width * 0.7,
            height: 40
        )
        emailInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        emailInput.layer.cornerRadius = 5
        emailInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(emailInput)
    }

    private func configurateSaveButton() {
        saveButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.2,
            y: self.bounds.minY + 265,
            width: self.bounds.width * 0.6,
            height: 40
        )
        saveButton.backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 0.7)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.layer.cornerRadius = 5

        addSubview(saveButton)
    }
}
