//
//  APIErrors.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

// MARK: - API errors enum
enum APIError: Error {
    case unreachable
    case invalidData
    case jsonDecodingFailure
    case responseUnsuccessful(description: String)
    case decodingTaskFailure(description: String)
    case requestFailed(description: String)
    case jsonConversionFailure(description: String)
    case postParametersEncodingFalure(description: String)
}

// MARK: - API errors enum entension
extension APIError: CustomStringConvertible {
    var customDescription: String {
        switch self {
        case .unreachable: return "## Please check your internet connectivity ##"
        case .invalidData: return "## Invalid Data"
        case .jsonDecodingFailure: return "## APIError - JSON decoding Failure"
        case .responseUnsuccessful(let description): return "## APIError - Response Unsuccessful status code -> \(description)"
        case .decodingTaskFailure(let description): return "## APIError - decodingtask failure with error -> \(description)"
        case .requestFailed(let description): return "## APIError - Request Failed -> \(description)"
        case .jsonConversionFailure(let description): return "## APIError - JSON Conversion Failure -> \(description)"
        case .postParametersEncodingFalure(let description): return "## APIError - post parameters failure -> \(description)"
        }
    }
    
    var description: String { customDescription }
}
