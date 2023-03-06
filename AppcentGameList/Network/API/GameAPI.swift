//
//  GameAPI.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol GameAPIProtocol {
    func getGameList(url: String, page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
    func getGameDetail(url: String, id: Int, completion: @escaping (Result<GameDetailResponse, Error>) -> Void)
}

final class GameAPI: GameAPIProtocol {
    
    func getGameList(url: String, page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        let url = GameEndpoints.list(page: page).url
        
        NetworkManager.shared.createRequest(type: GameListResponse.self,
                                            url: url,
                                            method: .get) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getGameDetail(url: String, id: Int, completion: @escaping (Result<GameDetailResponse, Error>) -> Void) {
        let url = GameEndpoints.detail(id: id).url
        
        NetworkManager.shared.createRequest(type: GameDetailResponse.self,
                                            url: url,
                                            method: .get) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
