//
//  File.swift
//  Assignment
//
//  Created by Manshi Viramgama on 28/11/21.
//

import Foundation

// MARK: - HTTP Headers
enum HTTPHeader {
    case contentType(String)
    case accept(String)
    case authorization(String)
    
    var header: (field: String, value: String) {
        switch self {
        case .contentType(let value): return (field: "Content-Type", value: value)
        case .accept(let value): return (field: "Accept", value: value)
        case .authorization(let value): return (field: "Authorization", value: value)
        }
    }
}
