import Foundation
import Hermes

struct Actor {
    let id: Int
    let name: String
    
    init(from actor: APIActor) {
        self.init(id: actor.id, name: actor.name)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

final class ActorsInteractor {
    
    private let client: HermesClient
    private let encoder: JSONEncoder
    
    init() {
        client = HermesClient(with: "https://www.flicksbox.ru/api/v1")
        encoder = JSONEncoder()
    }
    
    struct ActorsResponse: Decodable {
        let actors: [APIActor]
    }
    
    func allActors(
        success: @escaping (APIResponse<ActorsResponse>) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        getActors(
            path: "/actors",
            responseType: APIResponse<ActorsResponse>.self,
            success: success,
            failure: failure
        )
    }
    
//    func getActorByID(
//        id: Int,
//        success: @escaping (APIResponse<ActorsResponse>) -> Void,
//        failure: @escaping (Error) -> Void
//    ) {
//        getActors(
//            path: String(format: "/actors/%d", id),
//            responseType: APIResponse<ActorsResponse>.self,
//            success: success,
//            failure: failure
//        )
//    }
    
    private func getActors<T>(
        path: String,
        responseType: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) where T: Decodable {
        let request = HermesRequest(
            method: .get,
            path: path
        )
        request.successHandler = { response in
            guard let data = response.data.decode(type: T.self) else {
                failure(InteractorError.emptyData)
                return
            }
            success(data)
        }
        request.errorHandler = { error in
            failure(error)
        }
        client.run(with: request)
    }
}
