//
//  ViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 05.03.2021.
//

import UIKit
import SafariServices

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

    @IBAction func clickOpenSite(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.flicksbox.ru")!)
        present(vc, animated: true, completion: nil)
    }
    
}

