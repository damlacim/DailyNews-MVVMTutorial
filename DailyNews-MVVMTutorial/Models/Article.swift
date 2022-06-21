//
//  Article.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation



struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    
    let title: String
    let description: String
    let author: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
}
