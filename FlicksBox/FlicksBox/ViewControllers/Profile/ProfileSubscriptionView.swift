//
//  ProfileSubscriptionView.swift
//  FlicksBox
//
//  Created by Alkirys on 03.04.2021.
//

import UIKit
import Botticelli

final class ProfileSubscriptionView: SBView {
    let subscriptionLabel: SBLabel
    let descriptionLabel: SBLabel
    let priceLabel: SBLabel
    let priceMounthLabel: SBLabel
    let uMoneyButton: SBButton
    let vkPayButton: SBButton
    let applePayButton: SBButton
    let bankCardButton: SBButton

    override init(frame: CGRect) {
        subscriptionLabel = SBLabel()
        descriptionLabel = SBLabel()
        priceLabel = SBLabel()
        priceMounthLabel = SBLabel()
        uMoneyButton = SBButton()
        vkPayButton = SBButton()
        applePayButton = SBButton()
        bankCardButton = SBButton()
        super.init(frame: frame)
        addSubview(subscriptionLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(priceMounthLabel)
        addSubview(uMoneyButton)
        addSubview(vkPayButton)
        addSubview(applePayButton)
        addSubview(bankCardButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        configurateSubscriptionLabel()
        configurateDescriptionLabel()
        configuratePriceLabel()
        configuratePriceMounthLabel()
        configurateUMoneyButton()
        configurateVkPayButton()
        configurateApplePayButton()
        configurateBankCardButton()
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

    private func configurateSubscriptionLabel() {
        subscriptionLabel.frame = CGRect(
            x: self.bounds.minX + 25,
            y: self.bounds.minY + 25,
            width: self.bounds.width / 2,
            height: 18
        )
        subscriptionLabel.text = "Подписка"
        subscriptionLabel.font = UIFont.systemFont(ofSize: 18)
        subscriptionLabel.textAlignment = .left
        subscriptionLabel.numberOfLines = 0
        subscriptionLabel.textColor = UIColor.white
        addSubview(subscriptionLabel)
    }

    private func configurateDescriptionLabel() {
        descriptionLabel.frame = CGRect(
            x: self.bounds.minX + 100,
            y: self.bounds.minY + 65,
            width: self.bounds.width - 125,
            height: 60
        )
        descriptionLabel.text = "Наличие подписки дает доступ к коллекции" +
            "из более N фильмов и сериалов в лучшем качестве"
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        descriptionLabel.sizeToFit()
        addSubview(descriptionLabel)
    }

    private func configuratePriceLabel() {
        priceLabel.frame = CGRect(
            x: self.bounds.minX + 25,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height / 2 - 20,
            width: 75,
            height: 20
        )
        priceLabel.text = "300 р"
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 0
        priceLabel.textColor = UIColor.white
        addSubview(priceLabel)
    }

    private func configuratePriceMounthLabel() {
        priceMounthLabel.frame = CGRect(
            x: self.bounds.minX + 25,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height / 2,
            width: 75,
            height: 15
        )
        priceMounthLabel.text = "месяц"
        priceMounthLabel.font = UIFont.systemFont(ofSize: 15)
        priceMounthLabel.textAlignment = .left
        priceMounthLabel.numberOfLines = 0
        priceMounthLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        addSubview(priceMounthLabel)
    }

    private func configurateUMoneyButton() {
        uMoneyButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height + 25,
            width: self.bounds.width * 0.7,
            height: 40
        )
        uMoneyButton.backgroundColor = UIColor(red: 140/255, green: 63/255, blue: 248/255, alpha: 1)
        uMoneyButton.setTitle("Юmoney", for: .normal)
        uMoneyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        uMoneyButton.layer.cornerRadius = 5
        addSubview(uMoneyButton)
    }

    private func configurateVkPayButton() {
        vkPayButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height + 90,
            width: self.bounds.width * 0.7,
            height: 40
        )
        vkPayButton.backgroundColor = UIColor(red: 83/255, green: 134/255, blue: 218/255, alpha: 1)
        vkPayButton.setTitle("VK Pay", for: .normal)
        vkPayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        vkPayButton.layer.cornerRadius = 5
        addSubview(vkPayButton)
    }

    private func configurateApplePayButton() {
        applePayButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height + 155,
            width: self.bounds.width * 0.7,
            height: 40
        )

        let appleLogoColor = UIColor(red: 34/255, green: 30/255, blue: 31/255, alpha: 1)

        let attachment = NSTextAttachment()
        attachment.image = SBIcon.applelogo?.withTintColor(
            appleLogoColor,
            renderingMode: .alwaysOriginal
        )
        let attachmentString = NSMutableAttributedString(attachment: attachment)

        let attributedStringColor = [NSAttributedString.Key.foregroundColor: appleLogoColor]
        let strLabelText = NSAttributedString(string: " Pay", attributes: attributedStringColor)
        attachmentString.append(strLabelText)

        applePayButton.backgroundColor = UIColor.white
        applePayButton.setAttributedTitle(attachmentString, for: .normal)
        applePayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        applePayButton.layer.cornerRadius = 5
        addSubview(applePayButton)
    }

    private func configurateBankCardButton() {
        bankCardButton.frame = CGRect(
            x: self.bounds.minX + self.bounds.width * 0.15,
            y: self.bounds.minY + 65 + descriptionLabel.frame.height + 220,
            width: self.bounds.width * 0.7,
            height: 40
        )
        bankCardButton.backgroundColor = UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 0.7)
        bankCardButton.setTitle("Банковской картой", for: .normal)
        bankCardButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bankCardButton.layer.cornerRadius = 5
        addSubview(bankCardButton)
    }
}
