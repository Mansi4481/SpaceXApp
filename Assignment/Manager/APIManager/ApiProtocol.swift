//
//  ApiProtocol.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

// MARK: - API protocol
protocol ApiProtocol {
    func fetch<T: Decodable>(with endpoint: HTTPRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    
    func postAction()
}

// MARK: - API protocol extension
extension ApiProtocol {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    // MARK: - Fetching request
    func fetch<T: Decodable>(with endpoint: HTTPRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard NetworkStateCheck.isConnectedToNetwork() else {
            completion(.failure(.unreachable))
            return
        }
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        if let parameterDictionary = endpoint.bodyParameters {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            urlRequest.httpBody = httpBody
        }
        
        endpoint.headers?.forEach { urlRequest.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        
        let task = decodingTask(with: urlRequest, decodingType: T.self) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ?
                    completion(.failure(.requestFailed(description: "\(error?.localizedDescription ?? "## Request Fail")"))) :
                    completion(.failure(.invalidData))
                    return
                }
                
                guard let value = decode(json) else {
                    completion(.failure(.jsonDecodingFailure))
                    return
                }
                
                completion(.success(value))
            }
        }
        task.resume()
    }
    // MARK: - Parsing response
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let _ = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "## Request Fail"))
                return
            }
            
            guard let data = data else { completion(nil, .invalidData); return }
            
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
                
            } catch let err {
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        
        return task
    }
    
    func postAction() {
        let Url = String(format: "https://api.spacexdata.com/v4/launches/query")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["options": ["limit" : 10,
                                               "page" : 15]]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            do {
                let gitData = try JSONDecoder().decode(Launches.self, from: data)
                print("response data:", gitData)
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}

/*
 Use this to avoid any parsing failures if some attributes
 of your model don't show up in the JSON AND your attribute is an optional.
 
 This avoids the verbose implementation of init(from decoder: Decoder) for every
 model class.
 
 Usage
 @OptionalDecodable var someProperty: SomeValueType?
 */
@propertyWrapper
struct OptionalDecodable<T: Decodable>: Decodable {
    
    var wrappedValue: T?
    
    init(from decoder: Decoder) throws {
        wrappedValue = try? (try? decoder.singleValueContainer())?.decode(T.self)
    }
    
    init() {
        wrappedValue = nil
    }
}
