//
//  SearchViewController.swift
//  FlicksBox
//
//  Created by Mac-HOME on 28.03.2021.
//

import UIKit
import Botticelli

final class SearchViewController: MainOutputController {
    
    private lazy var resultsGridView: ResultsGridView = {
        let viewFrame = CGRect(
            x: view.bounds.minX,
            y: searchBarView.bounds.maxY,
            width: view.bounds.width,
            height: view.bounds.height - searchBarView.bounds.maxY
        )
        return ResultsGridView(frame: viewFrame)
    }()
    private lazy var recGridView: RecommendationsGridView = {
        let viewFrame = CGRect(
            x: view.bounds.minX,
            y: searchBarView.bounds.maxY,
            width: view.bounds.width,
            height: view.bounds.height - searchBarView.bounds.maxY
        )
        return RecommendationsGridView(frame: viewFrame)
    }()
    private lazy var emptyResultView: SearchEmptyResultView = {
        let sideSpace: CGFloat = 20
        let viewFrame = CGRect(
            x: view.bounds.minX + sideSpace,
            y: view.bounds.minY,
            width: view.bounds.width - sideSpace * 2,
            height: view.bounds.height - 300
        )
        return SearchEmptyResultView(frame: viewFrame)
    }()
    private lazy var searchBarView: SearchBarView = {
        var viewFrame = CGRect(
            x: view.bounds.minX,
            y: view.bounds.minY,
            width: view.bounds.width,
            height: 100
        )
        return SearchBarView(frame: viewFrame)
    }()
    private lazy var searchBar: UISearchBar = { searchBarView.searchBar }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureGestures()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    func configureTabItem() {
        self.tabBarItem.title = "Поиск"
        self.tabBarItem.image = SBIcon.search // TODO: wtf?
    }
    
    private func configureSubviews() {
        view.addSubview(emptyResultView)
        view.addSubview(resultsGridView)
        view.addSubview(recGridView)
        view.addSubview(searchBarView)
        showRecommendationsGridView()
    }
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(panGesture)
        
        let scrollGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        scrollGesture.delegate = resultsGridView.collectionView
        self.resultsGridView.collectionView.addGestureRecognizer(scrollGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    private func showEmptyResultView() {
        emptyResultView.isHidden = false
        resultsGridView.isHidden = true
        recGridView.isHidden = true
    }
    
    private func showResultsGridView() {
        emptyResultView.isHidden = true
        resultsGridView.isHidden = false
        recGridView.isHidden = true
    }
    
    private func showRecommendationsGridView() {
        emptyResultView.isHidden = true
        resultsGridView.isHidden = true
        recGridView.isHidden = false
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        showRecommendationsGridView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search(_:)), object: searchBar)
        
        // Check if searh text is empty
        var delay: TimeInterval
        if let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) == "" {
            delay = 0
        } else {
            delay = 0.75
        }
        perform(#selector(self.search(_:)), with: searchBar, afterDelay: delay)
    }

    @objc private func search(_ searchBar: UISearchBar) {
        // Check for empty query
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            showRecommendationsGridView()
            return
        }
        
        // Send request
        print(query)
        
        showResultsGridView()
    }
}
