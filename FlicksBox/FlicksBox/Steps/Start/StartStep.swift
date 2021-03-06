//
//  StartStep.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit

final class StartStep: BaseStep {
    static func step() -> UIViewController {
        return StartViewController()
    }
    
    static func next() {
        // do nothing
    }
}
