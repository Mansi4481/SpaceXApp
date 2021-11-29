import Foundation
import UIKit

/// Enum for Settings Request
enum LaunchEndpoints: HTTPRequest {
    case launchEnpoint(page: Int)
    
    var method: String {
        switch self {
        case .launchEnpoint:
            return HTTPMethods.POST.value
        }
    }
    var path: String {
        switch self {
        case .launchEnpoint:
            return "/v4/launches/query"
        }
    }
    var bodyParameters: NSMutableDictionary? {
        switch self {
        case .launchEnpoint(let page):
            let body: NSMutableDictionary = [:]
            body["options"] = ["limit": 10,
                               "page": page]
            return body
        }
    }
}

protocol LaunchRepository: ApiProtocol {
    var launches: [Launches] { get }
    func loadData(page:Int, completion: @escaping ((Launches?, APIError?) -> Void))
}

final class LaunchRepositoryImpl: LaunchRepository {
    var launches: [Launches] = []
    
    func loadData(page:Int, completion: @escaping ((Launches?, APIError?) -> Void)) {
        fetch(with: LaunchEndpoints.launchEnpoint(page: page), decode: { json -> Launches? in
            guard let results = json as? Launches else { return  nil }
            return results
        }) { result in
            switch result {
            case .success(let model):
                completion(model, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}


