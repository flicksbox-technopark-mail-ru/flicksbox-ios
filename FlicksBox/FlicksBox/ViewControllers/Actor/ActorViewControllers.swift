import Foundation

import Botticelli
import UIKit

final class ActorViewController: SBViewController {
    
    private var actorID: Int = 1;
    private var actorName: String = "Хуй с горы";
    private var actorsArray: [Actor] = [];
    
    private let actorModel = ActorContentModel()
    
    public func setActorID(id: Int) {
        actorID = id;
    }
    
    private lazy var actorNameLabel: SBLabel = {
        let actorNameLabel = SBLabel(frame: CGRect(x: 0, y: 65, width: view.bounds.maxX, height: 30))
        actorNameLabel.text = actorName
        actorNameLabel.textAlignment = .center
        return actorNameLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActors()
        setupSubviews()
    }
    
    private func loadActors() {
        actorModel.loadActors() { [weak self] actors in
            DispatchQueue.main.async {
                self?.actorsArray = actors
            }
        } failure: { [weak self] error in
            DispatchQueue.main.async {
                self?.alert(message: error)
            }
        }
    }
    
    private func setupSubviews() {
        view.addSubview(actorNameLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ActorViewController: MainOutput {
    func configureTabItem() {
        self.title = "Актёр"
    }
}
