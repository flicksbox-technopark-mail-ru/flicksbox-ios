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
    let ratingInteractor = RatingInteractor()
    
    var contentInfo: ContentInfo? {
        didSet {
            guard let info = contentInfo else {
                return
            }
            title = info.name
            nameLabel.text = title
            shortInfo.text = info.shortDescription
            originalNameInfo.descriptionText = info.originalName
            yearInfo.descriptionText = "\(info.year)"
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let shortInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .natural
        return label
    }()
    
    private let originalNameInfo = ContentInfoView(name: "Оригинальное название:")
    private let yearInfo = ContentInfoView(name: "Год выпуска:")
    private let ratingInfo = ContentInfoView(name: "Положительных оценок:")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let starImage = (contentInfo?.favourite ?? false) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteButtonClicked))
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(playButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(shortInfo)
        scrollView.addSubview(originalNameInfo)
        scrollView.addSubview(yearInfo)
        scrollView.addSubview(ratingInfo)
        
        playButton.addTarget(self, action: #selector(openPlayer), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let info = contentInfo else {
            alert(message: "Произошла ошибка, извиняемся :)")
            return
        }
        
        ratingInfo.descriptionText = "Загружаем..."
        ratingInteractor.get(contentId: info.contentId) { [weak self] rating in
            let color: UIColor
            if rating > 70 {
                color = .systemGreen
            } else if rating > 40 {
                color = .systemOrange
            } else {
                color = .systemRed
            }
            UIView.animate(withDuration: 0.3) {
                self?.ratingInfo.descriptionText = "\(rating)%"
                self?.ratingInfo.descriptionColor = color
            }
        } failure: { [weak self] error in
            self?.alert(message: error.localizedDescription)
        }

        
        imageView.loadWebP(url: info.largeImage)
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
        
        let nameFrame = nameLabel.sizeThatFits(CGSize(width: imageView.frame.width - 10, height: .infinity))
        nameLabel.frame = CGRect(origin: CGPoint(x: imageView.frame.minX, y: playButton.frame.maxY + 10), size: nameFrame)
        
        let shortFrame = shortInfo.sizeThatFits(CGSize(width: imageView.frame.width - 10, height: .infinity))
        shortInfo.frame = CGRect(origin: CGPoint(x: imageView.frame.minX, y: nameLabel.frame.maxY + 5), size: shortFrame)
        
        originalNameInfo.frame = CGRect(x: imageView.frame.minX, y: shortInfo.frame.maxY + 10, width: imageView.frame.width, height: 30)
        
        yearInfo.frame = CGRect(x: imageView.frame.minX, y: originalNameInfo.frame.maxY + 5, width: imageView.frame.width, height: 30)
        
        ratingInfo.frame = CGRect(x: imageView.frame.minX, y: yearInfo.frame.maxY + 5, width: imageView.frame.width, height: 30)
        
        let hScroll = 5 + imageView.frame.height + 10 + playButton.frame.height + 10 + nameLabel.frame.height + 5 + shortInfo.frame.height + 10 + originalNameInfo.frame.height + 5 + yearInfo.frame.height + 5 + ratingInfo.frame.height + 5
        scrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: max(hScroll, view.bounds.height + 2)
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
        guard let vc = FactoryViewControllers.createPlayer(video: content.video) else { return }
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}
