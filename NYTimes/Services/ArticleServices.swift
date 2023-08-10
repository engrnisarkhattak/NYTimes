//
//  ArticleServices.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 10/08/2023.
//

import Foundation

class ArticleServices {
    
    private let manager = APIManager()
    
    func getNetworkRequest(selectedPeriod: Period) -> URLRequest {
        
        let urlString = "\(BASE_URL)/\(MOST_VIEWED_ARTICLE)/\(selectedPeriod.rawValue ).json?api-key=\(API_KEY)"
        print("url string: \(urlString)")
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    func fetchArticleData(selectedPeriod: Period) async throws -> ArticleResult  {
        
        let request = self.getNetworkRequest(selectedPeriod: selectedPeriod)
        do {
            let response = try await manager.fetchDataWith(type: ArticleResult.self, with: request)
            return response
        }
        catch {
            throw error
        }
        
    }
    
}
