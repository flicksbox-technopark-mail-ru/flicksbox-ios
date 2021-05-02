//
//  SearchBarView.swift
//  FlicksBox
//
//  Created by Mac-HOME on 28.03.2021.
//

import UIKit
import Botticelli

final class SearchBarView: SBView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .gray
        searchBar.searchTextField.textColor = .white

        // Customize placeholder
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )

        // Customize corner radius
        searchBar.searchTextField.layer.cornerRadius = 1
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.masksToBounds = true

        // Delete background color
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)

        // Customize chanel button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white

        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    private func configureSubviews() {
        let barHeight: CGFloat = 60
        let sideSpace: CGFloat = 10

        searchBar.frame = CGRect(
            x: bounds.minX + sideSpace,
            y: bounds.maxY - barHeight,
            width: bounds.width - sideSpace * 2,
            height: barHeight
        )
        addSubview(searchBar)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimationLoading() {
        searchBar.isLoading = true
    }

    func stopAnimationLoading() {
        searchBar.isLoading = false
    }
}

// Extension for search loading indicator
extension UISearchBar {
    public var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            return textField
        }
    }

    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .medium)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = textField?.backgroundColor ?? UIColor.white
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
