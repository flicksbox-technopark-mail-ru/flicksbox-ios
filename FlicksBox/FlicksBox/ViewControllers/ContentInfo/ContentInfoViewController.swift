//
//  FilmInfoViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit
import Botticelli
import AVKit
import AVFoundation

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
    
    private let imageView: SBImageView = {
        let image = SBImageView()
        image.backgroundColor = .darkGray
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.imageEdgeInsets.left = -10
        button.setTitle("Смотреть", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ClientUser.shared.userData = nil
        
        let starImage = (contentInfo?.favourite ?? false) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteButtonClicked))
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(playButton)
        
        playButton.addTarget(self, action: #selector(openPlayer), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let imageUrl = contentInfo?.largeImage else {
            return
        }
        imageView.loadWebP(url: imageUrl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        let imageWidth = view.bounds.width - 10
        imageView.frame = CGRect(x: view.bounds.minX + 5, y: view.bounds.minY + 5, width: imageWidth, height: imageWidth * 9 / 16)
        
        let buttonWidth = imageView.frame.width / 2
        playButton.frame = CGRect(x: imageView.frame.midX - buttonWidth / 2, y: imageView.frame.maxY + 10, width: buttonWidth, height: 50)
        playButton.layer.cornerRadius = playButton.frame.height / 2
        
        
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: 5 + imageView.frame.height + 10 + playButton.frame.height
        )
    }
    
    @objc private func favoriteButtonClicked() {
        guard let info = contentInfo else {
            return
        }
        
        guard let _ = ClientUser.shared.userData else {
            self.alert(message: "Необходимо авторизоваться")
            return
        }
        let isFavorite = info.favourite ?? false
        
        guard isFavorite else {
            favouriteInteractor.add(contentId: info.contentId) { [weak self] in
                self?.contentInfo?.favourite = true
                UIView.animate(withDuration: 0.3) {
                    self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                }
            } failure: { [weak self] error in
                self?.alert(message: error.localizedDescription)
            }
            return
        }
        
        favouriteInteractor.delete(contentId: info.contentId) { [weak self] in
            self?.contentInfo?.favourite = false
            UIView.animate(withDuration: 0.3) {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            }
        } failure: { [weak self] error in
            self?.alert(message: error.localizedDescription)
        }
    }
    
    @objc private func openPlayer() {
        guard let content = contentInfo else { return }
        let videoURL = URL(string: content.video)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}
