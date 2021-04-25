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
}
