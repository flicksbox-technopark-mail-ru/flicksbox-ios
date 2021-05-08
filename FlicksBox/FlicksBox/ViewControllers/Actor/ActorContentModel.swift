import Foundation

final class ActorContentModel: NSObject {
    private let actorInteractor = ActorsInteractor()
    
    func loadActors(success: @escaping ([Actor]) -> Void, failure: @escaping (String) -> Void) {
        actorInteractor.allActors() { response in
            success(self.trasformate(actors: response.body?.actors ?? []))
        } failure: { error in
            failure(error.localizedDescription)
        }
    }
    
    private func trasformate(actors: [APIActor]) -> [Actor] {
        actors.map { actor -> Actor in
            Actor(from: actor)
        }
    }
}
