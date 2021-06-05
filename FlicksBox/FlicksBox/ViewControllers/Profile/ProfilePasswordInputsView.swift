//
//  ProfileNameInputsView.swift
//  FlicksBox
//
//  Created by Alkirys on 04.06.2021.
//

import UIKit
import Botticelli

final class ProfilePasswordInputsView: SBView {
    let oldPasswordLabel: SBLabel
    let oldPasswordInput: SBTextField
    let newPasswordLabel: SBLabel
    let newPasswordInput: SBTextField
    let againPasswordLabel: SBLabel
    let againPasswordInput: SBTextField

    override init(frame: CGRect) {
        oldPasswordLabel = SBLabel()
        oldPasswordInput = SBTextField()
        newPasswordLabel = SBLabel()
        newPasswordInput = SBTextField()
        againPasswordLabel = SBLabel()
        againPasswordInput = SBTextField()
        super.init(frame: frame)
        addSubview(oldPasswordLabel)
        addSubview(oldPasswordInput)
        addSubview(newPasswordLabel)
        addSubview(newPasswordInput)
        addSubview(againPasswordLabel)
        addSubview(againPasswordInput)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateOldPasswordLabel()
        configurateOldPasswordInput()
        configurateNewPasswordLabel()
        configurateNewPasswordInput()
        configurateAgainPasswordLabel()
        configurateAgainPasswordInput()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configurateView()
        configureSubviews()
    }

    private func configurateView() {
        self.backgroundColor = UIColor(red: 18/255, green: 17/255, blue: 16/255, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    func getData() -> UserPassword {
        return UserPassword(
            new_password: newPasswordInput.text ?? "",
            old_password: oldPasswordInput.text ?? "",
            repeated_new_password: againPasswordInput.text ?? ""
        )
    }

    private func configurateOldPasswordLabel() {
        oldPasswordLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: 0,
            width: self.bounds.width / 2,
            height: 20
        )

        oldPasswordLabel.text = "Старый пароль"
        oldPasswordLabel.textColor = UIColor.white
        oldPasswordLabel.font = UIFont.systemFont(ofSize: 20)

        addSubview(oldPasswordLabel)
    }

    private func configurateOldPasswordInput() {
        oldPasswordInput.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 30,
            width: self.bounds.width * 0.7,
            height: 40
        )

        oldPasswordInput.textColor = .black
        oldPasswordInput.tintColor = .black
        oldPasswordInput.isSecureTextEntry = true
        oldPasswordInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        oldPasswordInput.layer.cornerRadius = 5
        oldPasswordInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(oldPasswordInput)
    }

    private func configurateNewPasswordLabel() {
        newPasswordLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 80,
            width: self.bounds.width / 2,
            height: 20
        )

        newPasswordLabel.text = "Новый пароль"
        newPasswordLabel.textColor = UIColor.white
        newPasswordLabel.font = UIFont.systemFont(ofSize: 20)

        addSubview(newPasswordLabel)
    }

    private func configurateNewPasswordInput() {
        newPasswordInput.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 110,
            width: self.bounds.width * 0.7,
            height: 40
        )
        newPasswordInput.textColor = .black
        newPasswordInput.tintColor = .black
        newPasswordInput.isSecureTextEntry = true
        newPasswordInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        newPasswordInput.layer.cornerRadius = 5
        newPasswordInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(newPasswordInput)
    }
    
    private func configurateAgainPasswordLabel() {
        againPasswordLabel.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 160,
            width: self.bounds.width,
            height: 20
        )

        againPasswordLabel.text = "Повторите пароль"
        againPasswordLabel.textColor = UIColor.white
        againPasswordLabel.font = UIFont.systemFont(ofSize: 20)

        addSubview(againPasswordLabel)
    }

    private func configurateAgainPasswordInput() {
        againPasswordInput.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 190,
            width: self.bounds.width * 0.7,
            height: 40
        )

        againPasswordInput.textColor = .black
        againPasswordInput.tintColor = .black
        againPasswordInput.isSecureTextEntry = true
        againPasswordInput.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        againPasswordInput.layer.cornerRadius = 5
        againPasswordInput.font = UIFont.systemFont(ofSize: 20)

        addSubview(againPasswordInput)
    }
}
