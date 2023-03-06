//
//  NetworkManager.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}
    
    func createRequest<T: Codable>(type: T.Type,
                                   url: String,
                                   method: HTTPMethod,
                                   parameters: Parameters? = nil,
                                   headers: HTTPHeaders? = nil,
                                   completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers).validate().responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


