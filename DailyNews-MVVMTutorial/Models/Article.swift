//
//  Article.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation



struct ArticleList: Decodable {
    var articles: [Article]
}

struct Article: Decodable {
   
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    
    
}
