//
//  HTTPMethods.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

// MARK: - http methods
enum HTTPMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    
    /// HTTP Method as Strings
    var value: String {
        return self.rawValue
    }
}
