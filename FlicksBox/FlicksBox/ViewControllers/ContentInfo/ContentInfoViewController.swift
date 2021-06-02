//
//  FilmInfoViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit
import Botticelli

final class ContentInfoViewController: SBViewController {
    let favouriteInteractor = FavoritesInteractor()
    
    var contentInfo: ContentInfo? {
        didSet {
            self.title = contentInfo?.name
        }
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ClientUser.shared.userData = nil
        
        let starImage = (contentInfo?.favorite ?? false) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteButtonClicked))
        
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc private func favoriteButtonClicked() {
        guard let info = contentInfo else {
            return
        }
        
        guard let _ = ClientUser.shared.userData else {
            self.alert(message: "Необходимо авторизоваться")
            return
        }
        let isFavorite = info.favorite ?? false
        
        guard isFavorite else {
            favouriteInteractor.add(contentId: info.contentId) { [weak self] in
                self?.contentInfo?.favorite = true
                UIView.animate(withDuration: 0.3) {
                    self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                }
            } failure: { [weak self] error in
                self?.alert(message: error.localizedDescription)
            }
            return
        }
        
        favouriteInteractor.delete(contentId: info.contentId) { [weak self] in
            self?.contentInfo?.favorite = false
            UIView.animate(withDuration: 0.3) {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            }
        } failure: { [weak self] error in
            self?.alert(message: error.localizedDescription)
        }

    }
}
