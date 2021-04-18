//
//  FilmInfoViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 18.04.2021.
//

import Botticelli

final class FilmInfoViewController: SBViewController {
    var filmInfo: FilmInfo? {
        didSet {
            self.title = filmInfo?.name
        }
    }
}
