//
//  RecommendationsGridCell.swift
//  FlicksBox
//
//  Created by Mac-HOME on 29.03.2021.
//

import UIKit
import Botticelli
import AVKit
import AVFoundation

class RecommendationsGridCell: UICollectionViewCell {
    var content: ContentInfo? {
        didSet {
            guard oldValue?.contentId != content?.contentId,
                  let urlImage = content?.image else { return }
            titleLabel.text = content?.name
            poster.loadWebP(url: urlImage)
        }
    }
    
    private lazy var playButton: SBButton = {
        let button = SBButton(type: .custom)
        let image = UIImage(named: "play.png")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        return button
    }()
    
    private let poster: SBImageView = {
        let poster = SBImageView()
        poster.layer.cornerRadius = 5
        poster.clipsToBounds = true
        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = .darkGray
        return poster
    }()
    
    private lazy var titleLabel: SBLabel = {
        let label = SBLabel()
        label.baselineAdjustment = .alignCenters
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        contentView.addSubview(poster)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
    }
    
    private func configureView() {
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        let sideSpace: CGFloat = 10
        poster.frame = CGRect(
            x: contentView.bounds.minX,
            y: contentView.bounds.minY,
            width: contentView.bounds.height / 9 * 16,
            height: contentView.bounds.height
        )
        
        let buttonSize: CGFloat = 40
        playButton.frame = CGRect(
            x: contentView.bounds.maxX - buttonSize - sideSpace,
            y: contentView.bounds.minY + buttonSize / 2,
            width: buttonSize,
            height: buttonSize
        )
        
        titleLabel.frame = CGRect(
            x: poster.frame.maxX + sideSpace,
            y: contentView.frame.minY,
            width: contentView.frame.width - poster.bounds.width - buttonSize - sideSpace * 3,
            height: contentView.frame.height
        )
    }
    
    @objc private func playVideo() {
        guard let content = self.content else { return }
        let videoURL = URL(string: content.video)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.window?.rootViewController?.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
