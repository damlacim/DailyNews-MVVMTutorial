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
    
    @IBOutlet weak var newsDetail: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navigateButton: UIButton!
    
    var articles: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func navigateButtonClicked(_ sender: UIButton) {
        
    }
    
    func updateUI() {
        articles?.publishedAt = publishedLabel.text!
        image.kf.setImage(with: URL(string: articles!.urlToImage))
    }
    

}
