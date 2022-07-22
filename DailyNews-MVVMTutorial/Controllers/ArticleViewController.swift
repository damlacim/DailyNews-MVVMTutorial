//
//  NewsListTableViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation
import UIKit

class ArticleViewController: UITableViewController {
    // MARK: Private Variables
    private var articleListVM : ArticleListViewModel!
    private var selectIndex = 0
   
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Private Functions
    private func setup() {
        callTheViewModel()
        subscribeViewModel()
        articleListVM.fetchData()
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
    
    // MARK: Function
    func callTheViewModel() {
        self.articleListVM = ArticleListViewModel()
    }
    
}

// MARK: Extension
extension ArticleViewController {
 
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
        tableView.deselectRow(at: indexPath, animated: true)
        selectIndex = indexPath.row
        print(selectIndex)
        performSegue(withIdentifier: "detail", sender: self)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            let articleVM = self.articleListVM.articleIndex(selectIndex)
            detailViewController.articles = articleVM
            print(articleVM)
        }
    }
}
