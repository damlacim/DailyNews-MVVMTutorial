//
//  DetailViewModel.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 4.07.2022.
//

import Foundation

class DetailViewModel {
    // MARK: Function
    func getURL(url: String) -> URL {
        return URL(string: url)!
    }
}
