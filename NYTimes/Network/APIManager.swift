//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import Foundation

final class APIManager: APIHandler {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
}
