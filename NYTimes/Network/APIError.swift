//
//  APIError.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import Foundation

enum APIError: Error {
    case requestFailed(description: String)
    case invalidData
    case invalidUrl
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet

    var descriptionValue: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case .invalidUrl: return "Invalid Url"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        }
    }
}
