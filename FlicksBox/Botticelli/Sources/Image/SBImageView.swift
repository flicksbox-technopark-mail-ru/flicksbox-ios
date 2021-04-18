//
//  SBImageView.swift
//  Botticelli
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit
import SDWebImageWebPCoder

public class SBImageView: UIImageView {
    public func loadWebP(url: String, success: (() -> Void)? = nil) {
        let WebPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(WebPCoder)
        guard let webpURL = URL(string: url) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.sd_setImage(with: webpURL, completed: { (image, error, caheType, url) in
                success?()
            })
        }
    }
}
