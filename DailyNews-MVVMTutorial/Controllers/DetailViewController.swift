//
//  DetailViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 19.06.2022.
//

import Foundation
import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navigateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var articles: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func navigateButtonClicked(_ sender: UIButton) {
        
    }
    
    func updateUI() {
        publishedLabel.text = articles?.publishedAt
        descriptionLabel.text = articles?.description
        image.kf.setImage(with: URL(string: articles!.urlToImage))
    }
    

}
