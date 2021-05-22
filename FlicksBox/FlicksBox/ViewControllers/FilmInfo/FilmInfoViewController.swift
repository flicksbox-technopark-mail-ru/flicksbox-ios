//
//  FilmInfoViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 18.04.2021.
//

import UIKit
import Botticelli

final class FilmInfoViewController: SBViewController {
    var contentInfo: ContentInfo? {
        didSet {
            self.title = contentInfo?.name
        }
    }
}
