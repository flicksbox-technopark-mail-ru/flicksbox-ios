//
//  SearchEmptyResultView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 29.03.2021.
//

import UIKit
import Botticelli

final class SearchEmptyResultView: SBView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    private func configureSubviews() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)
        ]
        let descTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ]

        let title = NSMutableAttributedString(
            string: "Мы ничего не нашли.",
            attributes: titleTextAttributes
        )
        let desc = NSMutableAttributedString(
            string: "\nПопробуйте выполнить поиск другого фильма или сериала.",
            attributes: descTextAttributes
        )

        let message = NSMutableAttributedString()
        message.append(title)
        message.append(desc)

        let messageLabel = SBLabel()
        messageLabel.frame = bounds
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        messageLabel.attributedText = message
        addSubview(messageLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
