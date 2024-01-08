//
//  Article.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 3.01.2024.
//

import Foundation

struct Article: Codable {
    
    struct Source: Codable {
        let id: String?
        let name: String?
    }
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
