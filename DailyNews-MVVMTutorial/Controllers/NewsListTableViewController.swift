//
//  NewsListTableViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setup() {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=re&apiKey=8b4b61575b454d3595702ea4ca663c08")!
        
        WebService().getArticles(url: url, object: [ArticleList].self) { model, error in
            
            if model == nil {
                print(error?.localizedDescription)
            }
            
            
            
        }
    }
    
    
    
}
