//
//  ArticleListViewModel.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import Foundation
import SwiftUI

enum Period: Int, CaseIterable {
    
    case OneDay = 1
    case oneWeek = 7
    case oneMonth = 30
    
    var value: String {
        switch self {
        case .OneDay:
            return "One Day"
        case .oneMonth:
            return "One Month"
        default:
            return "One Week"
        }
    }
    
}
@MainActor
final class ArticleListViewModel: ObservableObject {
    
    private let manager = NetworkManager()
    @Published var selectedPeriod: Period = .oneWeek
    
    @Published var searchText: String = ""
    
    @Published private(set) var articles: [Article] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var showLoader: Bool = false
    
    

    var filterdArticles: [Article] {
        get {
            return searchText.count > 0 ? articles.filter { $0.title!.localizedCaseInsensitiveContains(searchText)} : articles
        }
        
    }
    
    var request: URLRequest {
        let urlString = "\(BASE_URL)/\(MOST_VIEWED_ARTICLE)/\(selectedPeriod.rawValue ).json?api-key=\(API_KEY)"
        print("url string: \(urlString)")
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    
    func fetchArticleData() async {
        
        self.showLoader = true
        do {
            let response = try await manager.fetchDataWith(type: ArticleResult.self, with: request)
            articles = response.results?.compactMap({ $0 }) ?? []
            showLoader = false
        }
        catch {
            errorMessage = "\((error as! APIError).descriptionValue)"
            hasError = true
            showLoader = false
        }
        
    }
}
