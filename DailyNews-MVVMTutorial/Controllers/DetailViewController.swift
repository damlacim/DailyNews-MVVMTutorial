//
//  DetailViewController.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 19.06.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var urlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateUrl(_ sender: UIButton) {
        
    }
    
    
}
