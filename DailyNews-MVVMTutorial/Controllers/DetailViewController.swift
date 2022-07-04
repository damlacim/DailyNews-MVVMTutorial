//
//  DetailViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 19.06.2022.
//

import Foundation
import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {
    // MARK: public variables
    public var articles: Article?
    
    // MARK: private variables
    private let detailViewModel = DetailViewModel()
    
    // MARK: IBOutlets
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navigateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: IBAction
    @IBAction func navigateButtonClicked(_ sender: UIButton) {
        let url = detailViewModel.getURL(url: articles!.url)
        let viewController = SFSafariViewController(url: url)
        present(viewController,animated: true)
    }
    
    // MARK: Function
    private func updateUI() {
        publishedLabel.text = articles?.publishedAt
        descriptionLabel.text = articles?.description
        image.kf.setImage(with: URL(string: articles!.urlToImage))
    }
}
