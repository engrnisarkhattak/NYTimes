//
//  APIHandler.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import Foundation

protocol APIHandler {
    var session: URLSession { get }
    func fetchDataWith<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension APIHandler {
    func fetchDataWith<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Invalid response")
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
