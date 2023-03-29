//
//  GameAPI.swift
//  Games
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol GameAPIProtocol {
    func getGameList(page: Int, completion: @escaping (Result<[Game], Error>) -> Void)
    func getGameDetail(id: Int, completion: @escaping (Result<GameDetailResponse, Error>) -> Void)
}

final class GameAPI {
    
    static let shared = GameAPI()
    
    private init() {}
}

extension GameAPI: GameAPIProtocol {
    
    func getGameList(page: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
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
    
    func getGameDetail(id: Int, completion: @escaping (Result<GameDetailResponse, Error>) -> Void) {
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
