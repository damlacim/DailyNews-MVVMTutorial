//
//  NewsListTableViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController, ArticleViewControllerDelagate {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        articleListVM = ArticleListViewModel()
        subscribeViewModel()
        articleListVM.fetchData()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func subscribeViewModel() {
        
        articleListVM.listenViewModel { [weak self] state in
            
            switch state {
            case .loading:
                print("loading")
            case .done:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension NewsListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell",for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        let articleVM = self.articleListVM.articleIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
}
