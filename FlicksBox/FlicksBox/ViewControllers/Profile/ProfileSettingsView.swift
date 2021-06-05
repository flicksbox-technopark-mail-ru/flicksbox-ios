//
//  ProfileSettingsView.swift
//  FlicksBox
//
//  Created by Alkirys on 04.04.2021.
//

import UIKit
import Botticelli

final class ProfileSettingsView: SBView {
    let nameSettingsButton: SBButton
    let passwordSettingsButton: SBButton
    var inputsView: SBView
    let saveButton: SBButton
    
    var isNamesChanges = true

    init(frame: CGRect, nickname: String, email: String) {
        nameSettingsButton = SBButton()
        passwordSettingsButton = SBButton()
        inputsView = ProfileNameInputsView(frame: CGRect(
            x: 25,
            y: 175,
            width: frame.width,
            height: 175
        ), nickname: nickname, email: email)
        saveButton = SBButton()
        super.init(frame: frame)
        addSubview(nameSettingsButton)
        addSubview(passwordSettingsButton)
        addSubview(inputsView)
        addSubview(saveButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateInputsView()
        configurateSaveButton()
        configurateNameSettingsButton()
        configuratePasswordSettingsButton()
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

    private func configurateNameSettingsButton() {
        nameSettingsButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.2,
            y: self.bounds.minY + 25,
            width: self.bounds.width * 0.3,
            height: 25
        )
        if isNamesChanges == false {
            nameSettingsButton.backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        } else {
            nameSettingsButton.backgroundColor = UIColor(red: 90/255, green: 118/255, blue: 132/255, alpha: 1)
        }
        nameSettingsButton.setTitle("Информация", for: .normal)
        nameSettingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        nameSettingsButton.layer.cornerRadius = 5
        nameSettingsButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        nameSettingsButton.addTarget(self, action:#selector(self.changeViewToName), for: .touchUpInside)
        
        addSubview(nameSettingsButton)
    }
    
    private func configuratePasswordSettingsButton() {
        passwordSettingsButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.2 + self.bounds.width * 0.3,
            y: self.bounds.minY + 25,
            width: self.bounds.width * 0.3,
            height: 25
        )
        if isNamesChanges == true {
            passwordSettingsButton.backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        } else {
            passwordSettingsButton.backgroundColor = UIColor(red: 90/255, green: 118/255, blue: 132/255, alpha: 1)
        }
        
        passwordSettingsButton.setTitle("Безопасность", for: .normal)
        passwordSettingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        passwordSettingsButton.layer.cornerRadius = 5
        passwordSettingsButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        passwordSettingsButton.addTarget(self, action:#selector(self.changeViewToPassword), for: .touchUpInside)
        
        addSubview(passwordSettingsButton)
    }
    
    @objc private func changeViewToName() {
        isNamesChanges = true
        
        inputsView.removeFromSuperview()
        
        inputsView = ProfileNameInputsView(frame: CGRect(
            x: 0,
            y: 75,
            width: self.bounds.width,
            height: 175
        ), nickname: ClientUser.shared.userData?.nickname ?? "", email: ClientUser.shared.userData?.email ?? "")
        
        self.addSubview(inputsView)

    }
    
    @objc private func changeViewToPassword() {
        isNamesChanges = false
        
        inputsView.removeFromSuperview()
        
        inputsView = ProfilePasswordInputsView(frame: CGRect(
            x: 0,
            y: 75,
            width: self.bounds.width,
            height: 245
        ))

        self.addSubview(inputsView)
    }

    private func configurateInputsView() {
        if isNamesChanges == true {
            inputsView.frame = CGRect(
                x: 0,
                y: 115,
                width: self.bounds.width,
                height: 175
            )
        } else {
            inputsView.frame = CGRect(
                x: 0,
                y: 75,
                width: self.bounds.width,
                height: 245
            )
        }
        
        addSubview(inputsView)
    }

    private func configurateSaveButton() {
        saveButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.2,
            y: self.bounds.minY + 335,
            width: self.bounds.width * 0.6,
            height: 40
        )
        saveButton.backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 0.7)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        saveButton.layer.cornerRadius = 5

        saveButton.addTarget(self, action:#selector(self.testRequest), for: .touchUpInside)
        
        addSubview(saveButton)
    }
    
    var changeUserInfo: ((String, String) -> Void) = {_,_ in }
    
    @objc private func testRequest() {
        let userInteractor = UserInteractor()

        if isNamesChanges == true {
            
            let data = (inputsView as! ProfileNameInputsView).getData()
            
            userInteractor.changeName(data: data) { response in
                if let error = response.error {
                    print(error.user_message)
                    return
                }
                guard let user = response.body?.user else {
                    print("Неизвестная ошибка")
                    return
                }

                (self.inputsView as! ProfileNameInputsView).setData(username: user.nickname, email: user.email)
                (self.changeUserInfo)(user.nickname, user.email)
                
            } failure: { error in
                print(error.localizedDescription)
            }
        } else {
            let data = (inputsView as! ProfilePasswordInputsView).getData()
            
            userInteractor.changePassword(data: data) { response in
                if let error = response.error {
                    print(error.user_message)
                    return
                }
                guard let user = response.body?.user else {
                    print("Неизвестная ошибка")
                    return
                }
                
            } failure: { error in
                print(error.localizedDescription)
            }
        }
    }
}
