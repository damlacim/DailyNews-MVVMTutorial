//
//  WebService.swift
//  DailyNews-MVVMTutorial
//
//  Created by Damla Çim on 29.03.2022.
//

import Foundation

class WebService {
    
    enum ResponseError: Error {
        case Unauthenticated
        case NoQuestionsFound
        case Unknown
        case decodingError(Error)
    }
    
    typealias CompletionHandler = ((Decodable?, ResponseError?) -> Void)
    
    func getArticles<T>(url: URL, object: T.Type, handler: @escaping CompletionHandler) where T: Decodable {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                handler(nil, .decodingError(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    if let safeData = data {
                        self.parseJSON(object: object, data: safeData, handler: handler)
                    }
                case 401:
                    handler(nil, .Unauthenticated)
                default:
                    handler(nil, .Unknown)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON<T>(object: T.Type, data: Data, handler: @escaping CompletionHandler) where T: Decodable {
        
        do {
            let baseResponse = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                handler(baseResponse, nil)
            }
            
        } catch (let error) {
            DispatchQueue.main.async {
                handler(nil, .decodingError(error))
            }
        }
        
    }
    
    
    
}
