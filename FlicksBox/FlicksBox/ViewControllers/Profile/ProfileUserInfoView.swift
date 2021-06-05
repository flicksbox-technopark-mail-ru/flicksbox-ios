//
//  ProfileUserInfoView.swift
//  FlicksBox
//
//  Created by Alkirys on 31.03.2021.
//

import UIKit
import Botticelli

final class ProfileUserInfoView: SBView {
    let avatarImage: SBImageView
    let userNameLabel: SBLabel
    let emailLabel: SBLabel
    let exitButton: SBButton

    init(frame: CGRect, nickname: String, email: String) {
        userNameLabel = SBLabel()
        userNameLabel.text = nickname.uppercased()
        emailLabel = SBLabel()
        emailLabel.text = email
        exitButton = SBButton()
        avatarImage = SBImageView()
        super.init(frame: frame)
        addSubview(userNameLabel)
        addSubview(emailLabel)
        addSubview(exitButton)
        addSubview(avatarImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateAvatarImage()
        configurateUsernameLabel()
        configurateEmailLabel()
        configurateExitButton()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configurateView()
        configureSubviews()
    }

    private func configurateView() {
        self.backgroundColor = UIColor(red: 18/255, green: 17/255, blue: 16/255, alpha: 1)
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
    
    private func configurateExitButton() {
        exitButton.frame = CGRect(
            x: 125,
            y: self.bounds.maxY - 42,
            width: 130,
            height: 20
        )
        
        exitButton.contentHorizontalAlignment = .left
        exitButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        exitButton.setTitle("Выйти", for: .normal)
        let attributedText = NSAttributedString(string: "Text", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        exitButton.setAttributedTitle(attributedText, for: .selected)
        exitButton.setTitleColor(UIColor.white, for: .normal)
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        exitButton.addTarget(self, action:#selector(self.exit), for: .touchUpInside)
        
        addSubview(exitButton)
    }
    
    @objc private func exit() {
        ClientUser.shared.userData = nil
        
        (exitProfile ?? {})()
    }
    
    var exitProfile: (() -> Void)?
    
    func changeUserData(nickname: String, email: String) {
        userNameLabel.text = nickname.uppercased()
        emailLabel.text = email
    }
    
    private func configurateAvatarImage() {
        avatarImage.frame = CGRect(
            x: 25,
            y: 25,
            width: 75,
            height: 75
        )

        if let avatar = ClientUser.shared.userData?.avatar {
            print(avatar)
            if (avatar != "") {
                let url = URL(string:"https://www.flicksbox.ru" + avatar)
                    if let data = try? Data(contentsOf: url!)
                    {
                        avatarImage.image = UIImage(data: data)
                    } else {
                        avatarImage.image = UIImage(named: "avatar")
                    }
            } else {
                avatarImage.image = UIImage(named: "avatar")
            }
        } else {
            avatarImage.image = UIImage(named: "avatar")
        }
        
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 5
        addSubview(avatarImage)
    }
}
