//
//  MainOutput.swift
//  FlicksBox
//
//  Created by sn.alekseev on 20.03.2021.
//

import Botticelli

protocol MainOutput {
    func prepareForUse()
}

typealias MainOutputController = SBViewController & MainOutput
