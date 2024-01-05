//
//  ArticleReply.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 3.01.2024.
//

import Foundation

class ArticleResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
    
    init() {
        self.articles = []
    }
    init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}
