//
//  HTTPRequest.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

// MARK: - HTTPRequest protocol
protocol HTTPRequest {
    /// scheme
    var scheme: String { get }
    
    /// base URL
    var baseURL: String { get }
    
    /// API endpoint
    var path: String { get }

    /// API Params
    var parameters: [URLQueryItem]? { get }

    /// API Params
    var bodyParameters: NSMutableDictionary? { get }

    /// API method
    var method: String { get }
    
    /// API header
    var headers: [HTTPHeader]? { get }

}
// MARK: - HTTPRequest protocol extension
extension HTTPRequest {
    
    /// default scheme will be https
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    /// default base url will be root url from info.plist
    var baseURL: String {
        switch self {
        default:
            return "api.spacexdata.com"
        }
    }
    
    /// default method will be GET
    var method: String {
        switch self {
        default:
            return HTTPMethods.GET.value
        }
    }
    
    /// default nil parameters passing
    var bodyParameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    /// default nil parameters passing
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    /// default nil headers passing
    var headers: [HTTPHeader]? {
        switch self {
        default:
            return [HTTPHeader.contentType("Application/json")]
        }
    }
}
