//
//  StartViewController.swift
//  FlicksBox
//
//  Created by sn.alekseev on 07.03.2021.
//

import UIKit
import SafariServices

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSubviews()
        testRequest()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubviews() {
        let label = UILabel()
        label.frame = CGRect(
            x: view.bounds.midX - 100,
            y: view.bounds.midY - 50,
            width: 200,
            height: 100
        )
        label.text = "Приложение работает"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        
        let button = UIButton()
        button.frame = CGRect(
            x: label.frame.minX,
            y: label.frame.maxY + 20,
            width: 200,
            height: 100
        )
        button.setTitle("Открыть сайт", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action:#selector(self.presentSite), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func presentSite() {
        let vc = SFSafariViewController(url: URL(string: "https://www.flicksbox.ru")!)
        present(vc, animated: true, completion: nil)
    }
    
    private func testRequest() {
        let client = HermesClient(with: "https://www.flicksbox.ru/api/v1/")
        let request = HermesRequest(method: HermesMethod.get, path: "user/profile")
        request.successHandler = { response in
            print(response)
        }
        client.run(request: request)
    }

}
