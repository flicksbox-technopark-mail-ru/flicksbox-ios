//
//  BaseStep.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit

protocol BaseStep {
    static func step() -> UIViewController
    static func next()
}
