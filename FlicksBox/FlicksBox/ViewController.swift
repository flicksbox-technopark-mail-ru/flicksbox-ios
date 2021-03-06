//
//  ViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 05.03.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let client = HermesClient(with: "https://www.flicksbox.ru/api/v1/")
        let request = HermesRequest(method: HermesMethod.get, path: "user/profile")
        request.successHandler = { response in
            print(response)
        }
        client.run(request: request)
    }


}

