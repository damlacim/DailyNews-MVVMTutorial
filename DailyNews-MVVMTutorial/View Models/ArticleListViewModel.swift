//
//  ArticleViewModel.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation

// MARK: Enum
enum ViewState {
    case loading
    case done
}

// MARK: Protocol
protocol ArticleViewControllerDelagate: AnyObject {
    func reloadTableView()
}

class ArticleListViewModel {
    // MARK: Delegate
    weak var delegate: ArticleViewControllerDelagate?
    
    // MARK: Private variables
    private var articles: [Article]?
    private var viewStateBlock: ((ViewState) -> Void)?
    
    // MARK: Functions
    func listenViewModel(with completion: @escaping (ViewState) -> Void) {
        viewStateBlock = completion
    }
    
    func fetchData() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=8b4b61575b454d3595702ea4ca663c08") else {
            return
        }
        self.viewStateBlock?(.loading)
        WebService().getArticles(url: url) { articles in
            if let articles = articles {
                self.articles = articles
            }
            self.viewStateBlock?(.done)
        }
    }
}

// MARK: Extension
extension ArticleListViewModel {
  
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func articleIndex(_ index: Int) -> Article {
        guard let article = self.articles?[index] else {
            return Article(title: "", description: "", url: "", urlToImage: "", publishedAt: "")
        }
        return article
    }
}

