//
//  SBImageView.swift
//  Botticelli
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit

public class SBImageView: UIImageView {
    public func load(url urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
