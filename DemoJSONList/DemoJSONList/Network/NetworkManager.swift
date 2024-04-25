//
//  NetworkManager.swift
//  DemoJSONList
//
//  Created by Mac on 25/04/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    
    private init() {}
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "NoData", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

