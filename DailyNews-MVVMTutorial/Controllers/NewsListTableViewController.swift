//
//  NewsListTableViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController, ArticleViewControllerDelagate {
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
        callToViewModel()
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
    func callToViewModel() {
        self.articleListVM = ArticleListViewModel()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Extension
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
