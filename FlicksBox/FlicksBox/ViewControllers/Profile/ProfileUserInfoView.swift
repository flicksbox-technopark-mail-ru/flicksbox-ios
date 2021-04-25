//
//  ProfileUserInfoView.swift
//  FlicksBox
//
//  Created by Alkirys on 31.03.2021.
//

import UIKit
import Botticelli

final class ProfileUserInfoView: UITableViewCell {
    static let identifier = "UserInfoViewCell"
    let avatarImage: SBImageView
    let userNameLabel: SBLabel
    let emailLabel: SBLabel
    let settingsLabel: SBLabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        userNameLabel = SBLabel()
//        userNameLabel.text = nickname.uppercased()
        userNameLabel.text = "Alkirys"
        emailLabel = SBLabel()
//        emailLabel.text = email
        emailLabel.text = "Alkirys@mail.ru"
        settingsLabel = SBLabel()
        avatarImage = SBImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(avatarImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateAvatarImage()
        configurateUsernameLabel()
        configurateEmailLabel()
        configurateSettingsLabel()
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

    private func configurateUsernameLabel() {
        userNameLabel.frame = CGRect(
            x: 125,
            y: 25,
            width: self.bounds.width / 2,
            height: 15
        )
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textAlignment = .left
        userNameLabel.numberOfLines = 0
        userNameLabel.textColor = UIColor.white
        addSubview(userNameLabel)
    }

    private func configurateEmailLabel() {
        emailLabel.frame = CGRect(
            x: 125,
            y: self.bounds.midY - 7,
            width: self.bounds.width / 2,
            height: 15
        )
        emailLabel.font = UIFont.systemFont(ofSize: 15)
        emailLabel.textAlignment = .left
        emailLabel.numberOfLines = 0
        emailLabel.textColor = UIColor.white
        addSubview(emailLabel)
    }

    private func configurateSettingsLabel() {
        settingsLabel.frame = CGRect(
            x: 125,
            y: self.bounds.maxY - 42,
            width: self.bounds.width / 2,
            height: 20
        )

        let attachment = NSTextAttachment()
        attachment.image = SBIcon.gearshape?.withTintColor(
            UIColor.white,
            renderingMode: .alwaysOriginal
        )
        let attachmentString = NSAttributedString(attachment: attachment)

        let strLabelText = NSMutableAttributedString(
                    string: "Настроить профиль",
                    attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
                )
        strLabelText.append(attachmentString)
        settingsLabel.attributedText = strLabelText

        settingsLabel.font = UIFont.systemFont(ofSize: 15)
        settingsLabel.textAlignment = .left
        settingsLabel.numberOfLines = 0
        settingsLabel.textColor = UIColor.white
        addSubview(settingsLabel)
    }

    private func configurateAvatarImage() {
        avatarImage.frame = CGRect(
            x: 25,
            y: 25,
            width: 75,
            height: 75
        )
        avatarImage.image = UIImage(named: "avatar.jpg")
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 5
        addSubview(avatarImage)
    }
}
