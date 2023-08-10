//
//  ArticleDTO.swift
//  NYTimes
//
//  Created by Nisar Ahmad on 09/08/2023.
//

import Foundation

struct ArticleResult: Codable {
    
    let status: String?
    let copyright: String?
    let num_results: Int?
    
    let results: [Article]?
    
    enum CodingKeys: CodingKey {
        case status
        case copyright
        case num_results
        case results
    }
}

struct Article: Codable {
    
    let id: Int?
    let asset_id: Int?
    let eta_id: Int?
    
    let uri: String?
    let url: String?
    let source: String?
    let published_date: String?
    let updated: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adx_keywords: String?
    let column: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    
    let des_facet: [String]?
    let org_facet: [String]?
    let per_facet: [String]?
    let geo_facet: [String]?
    
    let media: [ArticleMedia]?
    
    enum CodingKeys: CodingKey {
        case id
        case asset_id
        case eta_id
        case uri
        case url
        case source
        case published_date
        case updated
        case section
        case subsection
        case nytdsection
        case adx_keywords
        case column
        case byline
        case type
        case title
        case abstract
        case des_facet
        case org_facet
        case per_facet
        case geo_facet
        case media
    }
}

struct ArticleMedia: Codable {
    
    let approved_for_syndication: Int?
   
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    
    let media_metadata: [ArticleMediaMetaData]?
    
    enum CodingKeys: CodingKey {
        case approved_for_syndication
        case type
        case subtype
        case caption
        case copyright
        case media_metadata
    }
    
}

struct ArticleMediaMetaData: Codable {
    
    let height: Int?
    let width: Int?
   
    let url: String?
    let format: String?
   
    enum CodingKeys: CodingKey {
        case height
        case width
        case url
        case format
    }
}
