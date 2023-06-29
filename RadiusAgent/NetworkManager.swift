//
//  NetworkManager.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 28/06/23.
//

import Foundation

enum APIEndpoint {
    case facilityData
    
    var url: URL? {
        switch self {
        case .facilityData:
            return URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: APIEndpoint, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
